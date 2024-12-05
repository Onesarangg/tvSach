create database quanly_thuvien;
use quanly_thuvien;

-- Tạo bảng thẻ SV
create table theSV(
	maSV varchar(5) primary key,
    tenSV varchar(225) not null,
    chuyenNganh varchar(100) not null,
    dienThoai varchar(9) not null,
    email varchar(225) not null,
    ngayHetHan date not null
);

-- Tạo bảng Sách
create table Sach(
	maSach varchar(5) primary key,
	tenSach varchar(225) not null,
    maLoai varchar(5) not null,
    NXB varchar(225) not null,
    tacGia varchar(225) not null,
    soTrang int not null check (soTrang >5),
    banSao int not null check (banSao  > 1),
    giaTien float not null check (giaTien > 0),
    ngayNhapKho date not null,
    viTriDatSach varchar(225) not null
);

-- Tạo bảng Loại sách
create table loaiSach(
	maLoai varchar(5) primary key,
    tenLoai varchar(225) not null
);
alter table Sach add constraint loaiSach_Sach_fk foreign key (maLoai) references loaiSach(maLoai) on delete cascade;

-- Tạo bảng Phiếu Mượn
create table PhieuMuon(
	maPhieu int primary key auto_increment,
    ngayMuon date not null,
    ngayTra date not null,
    maSV varchar(5) not null,
    ghiChu varchar(225) not null
);
alter table PhieuMuon add constraint theSV_PhieuMuon_fk foreign key (maSV) references theSV(maSV) on delete cascade;

-- Tạo bảng chi tiết phiếu mượn
create table chitiet_pm(
	maPhieu int not null,
    maSach varchar(5) not null,
    ghiChu varchar(225) not null
);
alter table chitiet_pm add constraint PhieuMuon_chitiei_pm_fk foreign key (maPhieu) references PhieuMuon(maPhieu) on delete cascade;
alter table chitiet_pm add constraint Sach_chitiet_pm_fk foreign key (maSach) references Sach(maSach) on delete cascade;

-- Thêm DL vào bảng theSV
insert into thesv values ('SV001', 'An', 'Thiết kế đồ họa', '123456789', 'ansv001@fpt.vn', '20201231');
insert into thesv values ('SV002', 'Ân', 'Quản trị kinh doanh', '023456789', 'ansv002@fpt.vn', '20201231');
insert into thesv values ('SV003', 'Bảo', 'Lập trình di động', '034568921', 'baosv003@fpt.vn', '20201030');
insert into thesv values ('SV004', 'Chi', 'Nhà hàng - Khách sạn', '045679321', 'chisv004@fpt.vn', '20201230');
insert into thesv values ('SV005', 'Trang', 'Thiết kế website', '054789326', 'trangsv005@fpt.vn', '20201231');

-- Thêm DL vào bảng loaiSach
insert into loaisach values ('KD', 'Kinh doanh');
insert into loaisach values ('IT', 'Công nghệ thông tin');
insert into loaisach values ('TK', 'Thiết kế');
insert into loaisach values ('DS', 'Đời sống');
insert into loaisach values ('KS', 'Nhà hàng - Khách sạn');

-- Thêm DL vào bảng Sach
insert into sach value ('S0001', 'Marketing', 'KD', 'Moon', 'Trí Amber', '200', '2', '200000', '20100630', 'Kệ thứ 3');
insert into sach value ('S0002', 'Lập trình kỷ nguyên số', 'IT', 'Sky', 'Jack Lộc', '250', '3', '270000', '20170225', 'Kệ thứ 1');
insert into sach value ('S0003', 'Màu sắc của nhà thiết kế', 'TK', 'Star', 'Mạnh Cường', '100', '5', '300000', '20191231', 'Kệ thứ 4');
insert into sach value ('S0004', 'Tâm huyết ngành nghề', 'DS', 'Sea', 'Stellar Lee', '300', '2', '450000', '20200101', 'Kệ thứ 2');
insert into sach value ('S0005', 'Chủ - Nhân viên và khách', 'KS', 'Water', 'Linh Travel', '150', '9', '100000', '20150306', 'Kệ thứ 3');
insert into sach value ('S0006', 'Công nghệ số', 'IT', 'Sky', 'Tuấn Hennry', '500', '4', '600000', '20190202', 'Kệ thứ 1');

-- Thêm DL vào bảng phieumuon
insert into phieumuon values ('1', '20191203', '20191210', 'SV003', 'Đã trả sách');
insert into phieumuon values ('2', '20200330', '20200401', 'SV002', 'Đã trả sách');
insert into phieumuon values ('3', '20191205', '20191230', 'SV005', 'Chưa trả sách');
insert into phieumuon values ('4', '20200228', '20200310', 'SV004', 'Chưa trả sách');
insert into phieumuon values ('5', '20200120', '20200205', 'SV003', 'Đã trả sách');

-- Thêm DL vào bảng chitiet_pm
insert into chitiet_pm values ('2', 'S0003', 'Đã trả sách'); 
insert into chitiet_pm values ('4', 'S0002', 'Chưa trả sách'); 
insert into chitiet_pm values ('5', 'S0005', 'Đã trả sách');
insert into chitiet_pm values ('3', 'S0001', 'Chưa trả sách');  
insert into chitiet_pm values ('1', 'S0006', 'Đã trả sách'); 

-- 6.1 Liệt kê tất cả thông tin của các đầu sách gồm tên sách, mã sách, giá tiền , tác giả thuộc loại sách có mã “IT”. 
select maSach, tenSach, giaTien, tacGia from quanly_thuvien.sach where maLoai = 'IT';

-- 6.2  Liệt kê các phiếu mượn gồm các thông tin mã phiếu mượn, mã sách , ngày mượn, mã sinh viên có ngày mượn trong tháng 01/2017. 
select D.maPhieu, E.maSach, D.ngayMuon, D.maSV from quanly_thuvien.phieumuon D
inner join quanly_thuvien.chitiet_pm E on D.maPhieu = E.maPhieu 
where month(D.ngayMuon) = 1 and year(D.ngayMuon) = 2017;

-- 6.3 Liệt kê các phiếu mượn chưa trả sách cho thư viên theo thứ tự tăng dần của ngày mượn sách. 
select * from quanly_thuvien.phieumuon where ghiChu = 'Chưa trả sách' order by ngayMuon asc;

-- 6.4 Liệt kê tổng số đầu sách của mỗi loại sách ( gồm mã loại sách, tên loại sách, tổng số lượng sách mỗi loại). 
select count(B.maSach) as 'soLuongSach', C.maLoai, C.tenLoai from quanly_thuvien.sach B
inner join quanly_thuvien.loaisach C on B.maLoai = C.maLoai group by maLoai;

-- 6.5 Đếm xem có bao nhiêu  lượt sinh viên đã mượn sách. 
select count(quanly_thuvien.phieumuon.maPhieu) as 'Lượt SV mượn sách' from quanly_thuvien.phieumuon;

-- 6.6 Hiển thị tất cả các quyển sách có tiêu đề chứa từ khoá “SQL”. 
select * from quanly_thuvien.sach where tenSach like '%SQL%';

-- 6.7 Hiển thị thông tin mượn sách gồm các thông tin: mã sinh viên, tên sinh viên, mã phiếu mượn, tiêu đề sách, ngày mượn, ngày trả. Sắp xếp thứ tự theo ngày mượn sách. 
select A.maSV, A.tenSV, D.maPhieu, B.tenSach, D.ngayMuon, D.ngayTra from quanly_thuvien.thesv A 
inner join quanly_thuvien.phieumuon D on A.maSV = D.maSV 
inner join quanly_thuvien.chitiet_pm E on D.maPhieu = E.maPhieu
inner join quanly_thuvien.sach B on E.maSach = B.maSach
order by ngayMuon asc;

-- 6.8 Liệt kê các đầu sách có lượt mượn lớn hơn 20 lần. 
select * from quanly_thuvien.sach B
inner join quanly_thuvien.chitiet_pm E on E.maSach = B.maSach
group by E.maSach having count(E.maSach) > 20; 

-- 6.9 Viết câu lệnh cập nhật lại giá tiền của các quyển sách có ngày nhập kho trước năm 2014 giảm 30%. 
update quanly_thuvien.sach set giaTien = giaTien-giaTien * 0.3
where year(ngayNhapKho) < 2014;

-- 6.10 Viết câu lệnh cập nhật lại trạng thái đã trả sách cho phiếu mượn của sinh viên có mã sinh viên PD12301 (ví dụ). 
update quanly_thuvien.phieumuon set ghiChu = 'Đã trả sách' where maSV = 'SV005';

-- 6.11 Lập danh sách các phiếu mượn quá hạn chưa trả gồm các thông tin: mã phiếu mượn, tên sinh viên, email, danh sách các sách đã mượn, ngày mượn. 
select D.maPhieu, A.maSV, A.tenSV, A.email, B.maSach, B.tenSach, D.ngayMuon from quanly_thuvien.thesv A 
inner join quanly_thuvien.phieumuon D on A.maSV = D.maSV
inner join quanly_thuvien.chitiet_pm E on E.maPhieu = D.maPhieu
inner join quanly_thuvien.sach B on B.maSach = E.maSach
where to_days(D.ngayTra) - to_days(D.ngayMuon) >= 7 and D.ghiChu = "Chưa trả sách";

-- 6.12 Viết câu lệnh cập nhật lại số lượng bản sao tăng lên 5 đơn vị đối với các đầu sách có lượt mượn lớn hơn 10 
update quanly_thuvien.sach set banSao = banSao + 5 where maSach in
(select count(E.maSach) from quanly_thuvien.chitiet_pm E group by maSach having count(E.maSach) > 10); 

-- 6.13 Viết câu lệnh xoá các phiếu mượn có ngày mượn và ngày trả trước „1/1/2010‟ 
delete from quanly_thuvien.phieumuon D where to_days(20100101) > to_days(D.ngayMuon) and to_days(20100101) > to_days(D.ngayTra);

