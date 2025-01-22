return {
    {
        'dense-analysis/ale',
        config = function()
            vim.g.ale_linters = {
                dockerfile = { 'hadolint' }
            }
            vim.g.ale_fix_on_save = 0
            vim.g.ale_fixers = {}
        end
    }
}

