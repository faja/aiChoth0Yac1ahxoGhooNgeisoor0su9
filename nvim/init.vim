syntax on " to jest default? chyba, ale no niech bedzie

" {{{ basic set options
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" basic sutff
set guicursor= " jak wchodzisz do INSERT mode, to mordo zostawl BLOCK jako kursor, anie jak pizda kreseczke
set hidden " nie musisz "zapisac" pliku by zmienic buffor
set number " cyferki
set relativenumber " relatywne cyferki
set list " dont know why but I like it " jak uda sie zrobic to bardziej grey to super
" TODO
"lset listchars=...
set foldmethod=marker
set scrolloff=12 " super partia, jak schodzimy kursorem w dol, to zaczyna skrolowac 12 linit przed dolem
set updatetime=50
set noerrorbells " no do huja jak to moze nie byc default, wylacza irytujacy dzwoneczek

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabs
set tabstop=4     " ok, najpierw ile spacji to <TAB>, czyli jak jest w pliku <TAB> to bedzie wyswietlany jako 4 spacje
set softtabstop=4 " to samo co u gory tylko w przypadku wpisywania <TAB>, wiec jesli klikniemy <TAB> to nam sie wpisza 4 spacje
set shiftwidth=0  " o ile spacji przenosimy indentacje w lewo lub w prawo za pomoca `>>`/`<<`
                  " lub jesli mamy expandtab to tylk spacji zostanie zrobionych po wcisnieciu <TAB>
                  " jesli ustawione na 0, bierzemy wartosc z tabstop
set expandtab     " jesli wcisniemy <TAB> to vim wpisze nam <SPACE>*shiftwidth
set smartindent   " vim rozkminia kiedy zrobic autoindentacje

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" searching
"set smartcase=off " to jest default, wiec bedzie mogl by wywalony

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colors
" color configs goes after plugin install
" as I set colorscheme there

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" backup and swap
set undofile " save undo file, undodir is by default ~/.local/share/nvim/undo
set noswapfile
set nobackup

" set cmdheight=2 " wysykons lini na komendy, 1 is ok chyba
" set signcolumn=yes " extra kolumna dla linetrow i wyswietlania informacji

" Prime completeopt
" set completeopt=menuone,noinsert,noselect

let mapleader = " "

" source ~/.config/nvim/lua/mc.lua
lua << EOF
require('mc')
require('mc_go')
EOF
" }}}

" {{{ plugin install
call plug#begin('~/.local/share/nvim/plugged')

Plug 'aymericbeaumet/vim-symlink' " deals with symlinks correctly
Plug 'tpope/vim-surround' " surround plugin
Plug 'kyazdani42/nvim-web-devicons' " ikonki, oczywiscie trzeba miec font z nerd ikonkami: https://www.nerdfonts.com/font-downloads
Plug 'kyazdani42/nvim-tree.lua' " nerd tree

" colorscheme and syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'pineapplegiant/spaceduck'
Plug 'gruvbox-community/gruvbox'
Plug 'EdenEast/nightfox.nvim'

" vim line
Plug 'nvim-lualine/lualine.nvim'

" lsp stuff
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'ray-x/lsp_signature.nvim'

" telescope stuff
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do':'make'}

" git stuff
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

" cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'

" indent
Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()
" }}}

" {{{ colors
set colorcolumn=80
set termguicolors
" colorscheme spaceduck
" NonText is an end of line character
highlight NonText guifg=#30365F ctermfg=237 guibg=none ctermbg=233 gui=none cterm=none
colorscheme gruvbox
highlight Normal guibg=none
highlight EndOfBuffer guibg=none
" {{{ nightfox
" lua << EOF
" local nightfox = require('nightfox')
" 
" nightfox.setup({
"   fox = "nordfox", -- duskfox is also cool
"   transparent = true,
" })
" 
" nightfox.load()
" highlight NvimTreeNormal guibg=none
" EOF
" }}}

" diff colors
" for future reference
"   jesli uzywamy termguicolors, wazne sa tylko wartosci gui*
"       - gui   - "opcja", search for ':h attr-list' to see all options
"       - guifg - literki
"       - guibg - tlo
"   jesli uzywamy term based colors, wazne sa tylko wartosci cterm*
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=23 gui=bold guifg=LightGreen guibg=#01364F
highlight DiffDelete cterm=bold ctermfg=1 ctermbg=23 gui=bold guifg=LightRed guibg=#01364F
highlight DiffChange cterm=bold ctermfg=10 ctermbg=23 gui=bold guifg=LightGreen guibg=#01364F
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=bold guifg=LightGreen guibg=DarkRed
" }}}

" {{{ plugin configs
" {{{ telescope
lua <<EOF
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<c-k>"] = require('telescope.actions').move_selection_previous,
                ["<c-j>"] = require('telescope.actions').move_selection_next,
            }
        }
    },
    extensions = {
        fzf = {
           override_generic_sorter = true,  -- override the generic sorter
           override_file_sorter = true,     -- override the file sorter
           case_mode = "respect_case",      -- "smart_case" (default), "ignore_case", "respect_case"
                                            -- ja chce RESPECT!
        }
    }
}
require('telescope').load_extension('fzf')
EOF
" }}}
" {{{ ikonki
lua <<EOF
require('nvim-web-devicons').setup()
EOF
" }}}
" {{{ nvim-tree
" :help nvim-tree
lua <<EOF
require('nvim-tree').setup {
    git = {
        ignore = false,
    },
    renderer = {
        highlight_git = false,
        highlight_opened_files = "none",
        icons = {
            show = {
                git = true,
                folder = true,
                file = false,
                folder_arrow = true,
            },
        },
        indent_markers = {
            enable = true,
        },
    },
    update_cwd = true,
    update_focused_file = {
        enable      = true,
        update_cwd  = true,
        ignore_list = {}
  },
}
EOF
" }}}
" {{{ lsp config
lua <<EOF
-- if completion does not work for some reason
-- you have to update capabilities, eg:
-- 
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- require('lspconfig').gopls.setup{
--   capabilities = capabilities,
-- }

-- require('lspconfig').gopls.setup{
--   capabilities = capabilities,
-- }
require('lspconfig').gopls.setup{}
require'lspconfig'.solargraph.setup{}
require'lspconfig'.pyright.setup{}
-- require'lspconfig'.yamlls.setup{}

require "lsp_signature".setup {
    toggle_key = '<M-x>',
}
EOF
" }}}
" {{{ lualine
lua << END
require('lualine').setup()
-- require('lualine').setup {
--     options = {
--         component_separators = { left = '>', right = '<'},
--         section_separators = { left = '>', right = '<'},
--     }
-- }
END
" }}}
" {{{ git

" use vertical split by default when u dd, because nie chce mi sie klikac
" dv aby zrobic vertical split przy difie, dd jest szybsze i milsze w uzyciu
set diffopt+=vertical

lua << END
require('gitsigns').setup {
    keymaps = {
        noremap = true,
        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},
        ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
    },
}
END
" }}}
" {{{ cmp
set completeopt=menu,menuone,noselect
lua << EOF
local cmp = require "cmp"
local lspkind = require "lspkind"

cmp.setup {
    mapping = {
        -- ["<c-e>"] = cmp.mapping.clos(), -- this is actualy the default
        ["<c-p>"] = cmp.mapping.select_prev_item(),
		["<c-n>"] = cmp.mapping.select_next_item(),
        ["<tab>"] = cmp.mapping.confirm { select = true, },
        ["<c-i>"] = cmp.mapping.confirm { select = true, },
        ["<c-u>"] = cmp.mapping.scroll_docs(-4),
        ["<c-d>"] = cmp.mapping.scroll_docs(4),
        ["<c-space>"] = cmp.mapping.complete(),
    }, 

    -- global cmp sources
    sources = {
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "buffer",
        keyword_length = 4,

        -- completes only from visible buffers
        option = {
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end
        }
      },
    },

    formatting = {
      format = lspkind.cmp_format {
        with_text = true,
        menu = {
             buffer = "[buf]",
             nvim_lsp = "[LSP]",
             path = "[path]",
        },
      },
    },

    experimental = {
      native_menu = false,
      ghost_text = true,
    },
}

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'cmdline',
        keyword_length = 2,
      },
    })
  })
EOF
" }}}
" {{{ indent
lua << EOF
vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    enabled = false,
    show_first_indent_level = false,
    show_end_of_line = true,
    char_list = {'|', '¦', '┆', '┊'},
}
EOF
" }}}
" }}}

" {{{ remaps
" {{{ my remaps
" /home/mc/Dropbox/_my_work_environment_/.vimrc_files/mappings.vim

nnoremap Q :q<CR>
nnoremap <leader>v :e ~/.config/nvim/init.vim<CR>

" I just want my old good Y
nnoremap Y yy

" windows jumping
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>

" alt+h/j/k/l = ESCAPE
inoremap <m-h> <ESC>
inoremap <m-j> <ESC>j
inoremap <m-k> <ESC>k
inoremap <m-l> <ESC>l

" scroll
nnoremap <c-k> <c-y>k
nnoremap <c-j> <c-e>j

" tabsy mordo
nnoremap <c-t> :tabnew<CR>
nnoremap ( :tabprev<cr>
nnoremap ) :tabnext<cr>
nnoremap <leader>( :tabmove -1<cr>
nnoremap <leader>) :tabmove +1<cr>

" search and replace
nnoremap <leader>s :%s//<left>
nnoremap <leader>/ :noh<CR>
nnoremap <leader>" :s/'/"/g<CR>:noh<CR>
nnoremap <leader>' :s/"/'/g<CR>:noh<CR>

" quick fix list
map <leader>n :cnext<CR>
map <leader>p :cprevious<CR>
nnoremap <leader>c :cclose<CR>
nnoremap <leader>C :copen<CR>

" visual line move with autoindent
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" jump to a file under cursor in vsplit
nnoremap <leader><c-x> :vsplit<CR><c-w>lgf
" open a url under the cursor
nnoremap <c-w>gx :call jobstart(["xdg-open", expand("<cfile>")])<cr>

" echo full path to the current file
" nnoremap <leader>%! :echo expand('%:p')<cr>
" I'm disabling the above, as it's the same as: `CTRL+g` (or `1` then `CTRL+g`)
nnoremap <leader>%% :pwd<cr>
nnoremap <leader>%! :cd %:p:h<cr>

" TODO
" disable diagnostics
" :lua vim.diagnostic.disable()

" {{{ the ones I'm not using anymore
" repeat macro q on selected lines
""" vnoremap <leader>@ :normal @q<CR>

" repeat macro q on selected lines
""" vnoremap <leader>@ :normal @q<CR>

" source currnet line or V-block
""" vnoremap <leader>S y:@"<CR>
""" nnoremap <leader>S ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR>

" toggle wrap
""" nnoremap <leader>w :set wrap!<CR>

" tab -> %
""" nnoremap <tab> % " this breaks <C-i> as jump next

" left rightin command mode
""" cnoremap <c-j> <left>
""" cnoremap <c-k> <right>

" }}}
" }}}
" {{{ plugin remaps
" {{{ telescope
nnoremap <leader>o :Telescope find_files<cr>
nnoremap <leader>O :Telescope git_files<cr>
nnoremap <leader>b :Telescope buffers<cr>
nnoremap <leader>FFi :Telescope find_files cwd=~/GitRepos/AS/INFRA<cr>
nnoremap <leader>FFn :Telescope find_files cwd=~/.config/nvim<cr>
nnoremap <leader>FFm :Telescope find_files cwd=~/Dropbox/manuals<cr>
nnoremap <leader>FF.. :Telescope find_files cwd=..<cr>

"""""" grep stuff
" fuzzy find current buffer
" the below is fine, but for future reference I'll use custom luo function
" just to remember how to do this
" nnoremap <C-_> :lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
nnoremap <C-_> :lua require('mc').current_buffer_fuzzy_find()<cr>

" search for word under the cursor
nnoremap <leader>?? :lua require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") })<cr>
" search for ... whatever you type
nnoremap <leader>?/ :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ") })<cr>
" lajw grep
nnoremap <leader>?! :lua require('telescope.builtin').live_grep()<cr>
" }}}
" {{{ git
" out of the box: ]c -> next_hunk
" out of the box: [c -> prev_hunk
nnoremap <leader>Hdd :Gitsigns diffthis<CR>

nnoremap <leader>Hp :Gitsigns preview_hunk<CR>
nnoremap <leader>Hr :Gitsigns reset_hunk<CR>

nnoremap <leader>Hs :Gitsigns stage_hunk<CR>
nnoremap <leader>HS :Gitsigns stage_buffer<CR>

nnoremap <leader>Hu :Gitsigns undo_stage_hunk<CR>
nnoremap <leader>HU :Gitsigns reset_buffer_index<CR>
" }}}
" {{{ nvim tree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>f :NvimTreeFindFileToggle<CR>
" }}}
" {{{ lsp
" help vim.lsp.buf.<TAB>
"
" nice ones:
"   - hover()
"   - definition()
"   - code_action()
"   - rename()
"   - signature_help()
"   - :help vim.lsp.buf.<TAB>
nnoremap <leader>K :lua vim.lsp.buf.hover()<cr>
nnoremap <leader>D :lua vim.lsp.buf.definition()<cr>
nnoremap <leader>gr :lua vim.lsp.buf.references()<cr>

nnoremap ]d :lua vim.diagnostic.goto_next()<cr>
nnoremap [d :lua vim.diagnostic.goto_prev()<cr>

"
" }}}
" {{{ indent
nnoremap <leader>I :IndentBlanklineToggle<cr>
"
" }}}
" }}}
" }}}

" {{{ language specific stuff
" {{{ go
" autoformat go files
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
nnoremap <leader>Gi :lua goimports(1000)<cr>
" run goimports, the function is defined int ./lua/mc_go.lua
" autocmd BufWritePre *.go lua goimports(1000)
" }}}
" }}}
"
" TODO
"  - git icons in nvim tree
"  - lsp:
"     - configuration i mapings 
"     - for python
"     - for ruby
"     - yaml
"     - terraform
"
" NEW STUFF
" :help statusline
" set winbar=%=%m\ %f ####### %= move text to the right, %m file modified?, %f file name
