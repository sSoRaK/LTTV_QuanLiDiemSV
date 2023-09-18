-- 1. List SinhVien, order by MaSV ASC
select MaSV, HoSV, TenSV, HocBong
from dmsv
order by MaSV ASC;

-- 2. List SinhVien, group by Phai
select MaSV, concat(HoSV, ' ', TenSV) as HoTen, Phai, NgaySinh
from dmsv 
order by field(Phai,'Nam', 'Nữ'); -- trả về giá trị cột Phai

-- 3. Info SinhVien, order by NgaySinh ASC and HocBong DESC
select concat(HoSV, ' ', TenSV) as HoTen, NgaySinh, HocBong
from dmsv
order by NgaySinh ASC, HocBong DESC;

-- 4. List MonHoc, có tên bắt đầu bằng chữ 'T'
select MaMH, TenMH, SoTiet
from dmmh
where TenMH like 'T%';

-- 5. List SinhVien, có chữ cái cuối cùng trong tên 'I'
select concat(HoSV, ' ', TenSV) as HoTen, NgaySinh, Phai
from dmsv
where TenSV like '%I';

-- 6. List Khoa,  có ký tự thứ 2 của TenKhoa có chứa 'N'
select MaKhoa, TenKhoa
from dmkhoa
where TenKhoa like '_n%';

-- 7. List SinhVien, có họ "Thị"
select MaSV, concat(HoSV, ' ', TenSV) as HoTen
from dmsv
where HoSV like '%Thị%';

-- 8. List SinhVien có HocBong > 100.000 và order by MaKhoa DESC
select MaSV, concat(HoSV, ' ', TenSV) as HoTen, MaKhoa, HocBong
from dmsv 
where dmsv.HocBong > 100000 
order by MaKhoa DESC;

-- 9. List SinhVien có HocBong > 150.000 và sinh ở Hà Nội
select concat(HoSV, ' ', TenSV) as HoTen, MaKhoa, NoiSinh, HocBong
from dmsv
where HocBong > 150000 and NoiSinh like 'Hà Nội';

-- 10. List SinhVien Khoa Anh Văn và Vật Lý
select MaSV, MaKhoa, Phai
from dmsv
-- where MaKhoa not in('TH','TR');
where MaKhoa in('AV','VL');

-- 11. List SinhVien, có NgaySinh: 1991-01-01 đến 1992-06-05
select MaSV, NgaySinh, NoiSinh, HocBong
from dmsv
where NgaySinh between '1991-01-01' and '1992-06-05';

-- 12. List SinhVien có HocBong [80.000, 150.000]
select MaSV, NgaySinh, Phai, MaKhoa
from dmsv
where HocBong between 80000 and 150000;

-- 13. List MonHoc có số tiết [30, 45]
select MaMH, TenMH, SoTiet
from dmmh
where SoTiet between 30 and 45;

-- 14. List SinhVien (Nam) của khoa Anh Văn và Tin Học
select MaSV, concat(HoSV, ' ', TenSV) as HoTen, dmkhoa.TenKhoa, Phai
from dmsv
inner join dmkhoa on dmsv.MaKhoa = dmkhoa.MaKhoa 
 where dmsv.Phai like 'Nam' and (dmkhoa.TenKhoa like 'Anh Văn' or dmkhoa.TenKhoa like 'Tin Học');

-- 15. List SinhVien (Nữ), tên có chứa 'N'
select MaSV, concat(HoSV, ' ', TenSV) as HoTen, NgaySinh, MaKhoa, Phai
from dmsv
where Phai like 'Nữ' and TenSV like '%N%';

-- 16. List SinhVien có NoiSinh 'Hà Nội' , NgaySinh 'xxxx-02-xx'
select HoSV, TenSV, NoiSinh, NgaySinh
from dmsv
where NoiSinh like 'Hà Nội' and NgaySinh between '1990-02-01' and '1990-02-28';
 
-- 17. List SinhVien có tuổi lớn hơn 20
select concat(HoSV, ' ', TenSV) as HoTen, floor(datediff(now(), NgaySinh) / 365) as Tuoi, HocBong
from dmsv;

-- 18. List SinhVien có tuổi từ 20 - 25
select concat(HoSV, ' ', TenSV) as HoTen, floor(datediff(curdate(), NgaySinh) / 365) as Tuoi, TenKhoa
from dmsv
inner join dmkhoa on dmsv.MaKhoa = dmkhoa.MaKhoa
where floor(datediff(curdate(), NgaySinh) / 365) between 20 and 25;

-- 19. List SinhVien có năm sinh 1990
select concat(HoSV, ' ', TenSV) as HoTen, Phai, NgaySinh
from dmsv
where year(NgaySinh) = 1990;

-- 20. List HocBong, HocBong >= 500000 hiển thị 'Học bổng cao', otherwise 'Mức trung bình'
select MaSV, Phai, MaKhoa, HocBong
from dmsv
where HocBong >= 500000 like 'Học bổng cao';

-- 21. Tổng số SinhVien toàn trường
select count(MaSV) as TongSinhVien
from dmsv;

-- 22. Tổng số SinhVien, và SinhVien 'Nữ'
select 'Tổng sinh viên' as ' ', count(MaSV) as ' ' from dmsv
union
select 'Sinh viên nữ' as ' ', count(MaSV) from dmsv where Phai = 'Nữ';

-- 23. Tổng số SinhVien từng Khoa
select TenKhoa, count(*) as SoSinhVien from dmsv
inner join dmkhoa on dmsv.MaKhoa = dmkhoa.MaKhoa
group by TenKhoa;

-- 24. Cho biết số SinhVien học từng môn
select TenMH, count(*) as SoSinhVien from dmsv
inner join ketqua on ketqua.MaSV = dmsv.MaSV
inner join dmmh on ketqua.MaMH = dmmh.MaMH
group by TenMH;

-- 25. Tổng số MonHoc trong bảng KetQua (DISTINCT: duy nhất)
select count(distinct MaMH) as 'Tổng số môn học' from ketqua;

-- 26. Cho biết số HocBong mỗi Khoa
select TenKhoa, count(*) as SoHocBong from dmkhoa
group by TenKhoa;

-- 27. Cho biết HocBong cao nhất mỗi khoa
select TenKhoa, max(HocBong) as 'HocBong(max)' from dmkhoa
inner join dmsv on dmsv.MaKhoa = dmkhoa.MaKhoa
group by TenKhoa;

-- 28. Tổng số SV Nam và Nữ mỗi Khoa
select TenKhoa, Phai, count(*) from dmkhoa
inner join dmsv on dmsv.MaKhoa = dmkhoa.MaKhoa
group by TenKhoa, Phai;

-- 29. Cho biết SinhVien theo từng độ tuổi
select floor(datediff(curdate(), NgaySinh) / 365) as Tuoi, count(*) as SoLuong
from dmsv
group by floor(datediff(curdate(), NgaySinh) / 365);

-- 30. Cho biết những năm sinh có 2 SinhVien theo học tại trường
select year(NgaySinh) as NamSinh, count(*) = 2 as SoLuong
from dmsv
group by year(NgaySinh);









