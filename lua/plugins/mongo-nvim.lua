return {
  "thibthib18/mongo-nvim",
  config = function()
    require("mongo-nvim").setup({
      connection_string = "mongodb://127.0.0.1:27017",
      list_document_key = "_id",
      delete_document_mapping = nil, -- "<c-d>"
    })
  end,
}
