photoFolder = "/DCIM"
  
  --最新のディレクトリ名を取得
  local lastDirNum = 0
  local lastDirName = ""
  for dir in lfs.dir(photoFolder) do
    --フォルダの場合
    if(lfs.attributes(photoFolder.."/"..dir, "mode") == "directory") then
      local tmpDirNum = tonumber(dir:sub(1, 3))
      --現在の最新のフォルダ番号と比較
      if(tmpDirNum >= lastDirNum) then
        lastDirNum = tmpDirNum
        lastDirName = dir
      end
    end
  end

  --最新のファイル名を取得
  local lastFileNum = 0
  local lastFileName = ""
  for file in lfs.dir(photoFolder.."/"..lastDirName) do
    --ファイルの場合
    if(lfs.attributes(photoFolder.."/"..lastDirName.."/"..file, "mode") == "file") then
      local tmpFileNum = tonumber(file:sub(5, 8))
      --現在の最新のファイル番号と比較
      if(tmpFileNum >= lastFileNum) then
        lastFileNum = tmpFileNum
        lastFileName = file
      end
    end
  end
  
  --ファイルサイズ取得
  local filePath = photoFolder.."/"..lastDirName.."/"..lastFileName
  local fileSize = lfs.attributes(filePath,"size")
  if fileSize == nil then
    return
  end
  
  --dropBoxへアップロード
  b, c, h = fa.request{
    url = "https://api-content.dropbox.com/1/files_put/dropbox/" .. lastFileName .. "?overwrite=true",
    method = "PUT",
    headers = {["Authorization"] = "Bearer **dropBox access token here**",
    ["Content-Length"] = fileSize},
    file = filePath,
    bufsize = 1460*10
  }
print(c)
print(b)