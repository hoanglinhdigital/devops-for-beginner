#Tạo nhánh develop từ nhánh master của repository mới checkout.
git checkout -b develop
#Tạo/sửa một vài files vd: index.html, README.md
#Add files vào staging area.
git add .
#Commit files vào nhánh develop.
git commit -m "Add index.html and modify README.md"
#Push nhánh develop lên repository Github.
git push origin develop
