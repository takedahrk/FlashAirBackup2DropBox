local folder = "/Upload" 
local file = "IMGP0911.JPG"
local file_path = folder .. "/" .. file
  --get the size of the file
  local filesize = lfs.attributes(file_path,"size")
  if filesize ~= nil then
  else
    return
  end
  --Upload!
  b, c, h = fa.request{
    url = "https://api-content.dropbox.com/1/files_put/dropbox/"..file.."?overwrite=true",
    method = "PUT",
    headers = {["Authorization"] = "Bearer token",
    ["Content-Length"] = filesize},
    file=file_path,
    bufsize=1460*10
  }
print(c)
print(b)