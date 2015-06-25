function brat_roi_script_partial(jobman)

% nifti_list: cell of nifti files, e.g. nifti_list{1} = 'fdwrabrat_4D.nii'
% or, nifti_list{1}{1} = 'fdwrabrat_3D_001.nii', nifti_list{1}{2} = 'fdwrabrat_3D_002.nii'
% rois: cell of roi files
% subj_ids: cell of subject names or unique tokens
% mask: string of mask file
% out_pval: 0 or 1, output p value for correlation
% our_dir: string of ouput directory
% jobman_str: could be either 'roi2roi' or 'roi2wb'. In script, can be both --> {'roi2roi', 'roi2wb'}
% updated by kb at 2015-03-16


rois = jobman.rois;
mask = jobman.mask{1};
out_pval = jobman.outputP;
out_dir = jobman.out_dir{1};
roi2roi_ind = jobman.roi2roi;
roi2wb_ind = jobman.roi2wb;



if isempty(jobman.rois{1})
    error(sprintf('\tPlease input roi files!\n')); %#ok<*SPERR>
end

if isempty(jobman.input_nifti.dirs{1})
    error(sprintf('\tPlease input data directories!\n'));
end

if isempty(jobman.out_dir)
    error(sprintf('\tPlease input output directories!\n'));
end

if isempty(jobman.mask)
    error(sprintf('ROI files should be masked by a whole brain mask!\n'));
end

if roi2roi_ind == 0 && roi2wb_ind == 0
    warning(sprintf('\n\tNo correlation will be calculated\n\tOnly mean time serieses will be extracted!')); %#ok<*SPWRN>
end

[nifti_list, subj_ids] = brat_get_subjs(jobman.input_nifti);





% mask roi files
mask_nii = load_nii(mask);
size_mask = mask_nii.hdr.dime.dim(2:4);
mask_bin = mask_nii.img > 0.5;
mask_ind = find(mask_bin);

[rois_inds, rois_str] = brat_get_rois(rois, size_mask, mask_ind, '');
num_roi = numel(rois_inds);

if numel(rois_str) == 1 && roi2roi_ind == 1
    warning('Only one roi tag is detected, roi2roi correlation will not be calculated!');
    roi2roi_ind = 0;
end


% [rois_ind_x, rois_ind_y, rois_ind_z] = cellfun(@(x) ind2sub(roi_size, find(x)), rois_inds, 'UniformOutput', false);
num_subj = numel(nifti_list);

if out_pval == 1
    corr_p_tot = NaN([num_roi, num_roi, num_subj]);
end

if exist(out_dir, 'dir') ~= 7
    mkdir(out_dir);
end

if roi2wb_ind == 1
    out_roi2wb = fullfile(out_dir, 'roi2wb');
    if exist(out_roi2wb, 'dir') ~= 7
        mkdir(out_roi2wb);
    end
    
    out_roi_dirs = cellfun(@(x) fullfile(out_roi2wb, x), rois_str, 'UniformOutput', false);
    for m = 1:numel(out_roi_dirs)
        if exist(out_roi_dirs{m}, 'dir') ~= 7
            mkdir(out_roi_dirs{m});
        end
    end
    out_ts = fullfile(out_dir, 'mean_ts');
end

if roi2roi_ind == 1
    
    corr_r_tot = NaN([num_roi, num_roi, num_subj], 'single');
    corr_z_tot = NaN([num_roi, num_roi, num_subj], 'single');
    
    out_roi2roi = fullfile(out_dir, 'roi2roi');
    if exist(out_roi2roi, 'dir') ~= 7
        mkdir(out_roi2roi);
    end
    out_mat = fullfile(out_roi2roi, 'corr_mat');
    if exist(out_mat, 'dir') ~= 7
        mkdir(out_mat);
    end
    out_ts = fullfile(out_dir, 'mean_ts');
end

if exist(out_ts, 'dir') ~= 7
    mkdir(out_ts);
end

for m = 1:num_subj
    
    [data_2d_mat, data_tps, mask_ind_new] = brat_4D_to_mat(nifti_list{m}, size_mask, mask_ind, 'mat', subj_ids{m});
    
    ts_rois = NaN([data_tps, num_roi]);
    for n = 1:num_roi
        ts_rois_tmp = arrayfun(@(x) data_2d_mat(:, x), rois_inds{n}, 'UniformOutput', false);
        ts_rois_mat = cell2mat(ts_rois_tmp');
        ts_rois(:, n) = mean(ts_rois_mat, 2);
    end
    
    save(fullfile(out_ts, [subj_ids{m}, '_ts.mat']), 'ts_rois');
    
    if roi2roi_ind == 1
        fprintf('\tCalculating roi - roi correlation for subject %d/%d %s\n', m, num_subj, subj_ids{m});
        [corr_r, corr_p] = partialcorr(ts_rois);
        corr_r_tot(:, :, m) = corr_r;
        corr_z = 0.5 .* log((1 + corr_r) ./ (1 - corr_r));
        corr_z_tot(:, :, m) = corr_z;
        
        if out_pval == 1
            corr_p_tot(:, :, m) = corr_p;
            save(fullfile(out_mat, [subj_ids{m}, '_partialcorr.mat']), 'corr_r', 'corr_z', 'corr_p', 'rois_str');
        else
            save(fullfile(out_mat, [subj_ids{m}, '_partialcorr.mat']), 'corr_r', 'corr_z', 'rois_str');
        end
        
        clear('corr_r', 'corr_p', 'corr_z');
    end
    
    if roi2wb_ind == 1
        for n = 1:num_roi
            fprintf('\tCalculating roi - whole brain correlation for subject %d/%d %s, roi %s\n', m, num_subj, subj_ids{m}, rois_str{n});
            [corr_r_wb, corr_p_wb] = partialcorr(ts_rois(:, n), data_2d_mat,ts_rois(:,[1:n-1,n+1:end]));
            
            corr_out = nan(size_mask, 'single');
            corr_out(mask_ind_new) = corr_r_wb;
            filename = fullfile(out_roi_dirs{n}, ['partialcorr_R_', subj_ids{m}, '.nii']);
            nii = make_nii(corr_out, mask_nii.hdr.dime.pixdim(2:4), mask_nii.hdr.hist.originator(1:3));
            save_nii(nii, filename);
            
            corr_out = nan(size_mask, 'single');
            corr_z_wb = 0.5 .* log((1 + corr_r_wb) ./ (1 - corr_r_wb));
            corr_out(mask_ind_new) = corr_z_wb;
            filename = fullfile(out_roi_dirs{n}, ['partialcorr_Z_', subj_ids{m}, '.nii']);
            nii = make_nii(corr_out, mask_nii.hdr.dime.pixdim(2:4), mask_nii.hdr.hist.originator(1:3));
            save_nii(nii, filename);
            
            if out_pval == 1
                corr_out = nan(size_mask, 'single');
                corr_out(mask_ind_new) = corr_p_wb;
                filename = fullfile(out_roi_dirs{n}, ['partialcorr_P_', subj_ids{m}, '.nii']);
                nii = make_nii(corr_out, mask_nii.hdr.dime.pixdim(2:4), mask_nii.hdr.hist.originator(1:3));
                save_nii(nii, filename);
            end
            
            clear('corr_out', 'corr_r_wb', 'corr_p_wb', 'corr_z_wb');
        end
    end
    
    fprintf('\n');
    clear('data_2d_mat');
end

if roi2roi_ind == 1
    if out_pval == 1
        save(fullfile(out_dir, 'partialroi2roi_tot.mat'), 'corr_r_tot', 'corr_z_tot', 'corr_p_tot', 'rois_str', 'subj_ids');
    else
        save(fullfile(out_dir, 'partialroi2roi_tot.mat'), 'corr_r_tot', 'corr_z_tot', 'rois_str', 'subj_ids');
    end
end

fprintf('\tFinished!\n');



