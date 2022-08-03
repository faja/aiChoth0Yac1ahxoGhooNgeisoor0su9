local blabla = {}

blabla.current_buffer_fuzzy_find = function()
  require('telescope.builtin').current_buffer_fuzzy_find()
end

return blabla
