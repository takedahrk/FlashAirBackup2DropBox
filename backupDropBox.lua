folder = "/Upload" 
file = "IMGP0911.JPG"
access_token = "**dropBoxAccessToken**"
file_path = folder .. "/" .. file
  --ファイルサイズ取得
  local filesize = lfs.attributes(file_path,"size")
  if filesize == nil then
    return
  end
  
  --dropBoxへアップロード
  b, c, h = fa.request{
    url = "https://api-content.dropbox.com/1/files_put/dropbox/" .. file .. "?overwrite=true",
    method = "PUT",
    headers = {["Authorization"] = "Bearer " .. access_token,
    ["Content-Length"] = filesize},
    file = file_path,
    bufsize = 1460*10
  }
print(c)
print(b)