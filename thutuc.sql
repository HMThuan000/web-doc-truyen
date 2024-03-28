-- find comic by name
GO
CREATE PROC findcomic @TenTruyen NVARCHAR(300)
AS
BEGIN
SELECT *
FROM Truyen
inner join TacGia on Truyen.IdTacGia = TacGia.IdTacGia
WHERE upper(TenTruyen) LIKE upper(@TenTruyen) + '%'
END

exec findcomic 'a'

drop proc findcomic


--find comic by id
GO 
CREATE PROC findcomicbyid @ID INT 
AS 
BEGIN  
 SELECT * 
 FROM Truyen 
 INNER JOIN TacGia ON Truyen.IdTacGia = TacGia.IdTacGia
 WHERE IdTruyen=@ID 
END 

EXEC findcomicbyid @ID = 2; -- Thay 123 bằng giá trị ID mong muốn


drop proc findcomicbyid


-- get comic info
CREATE proc getcomicinfo
AS
BEGIN
    SELECT Truyen.*, TacGia.TenTacGia, COUNT(ChuongTruyen.TenChuong) AS SoLuongChuong
    FROM Truyen
    INNER JOIN TacGia ON Truyen.IdTacGia = TacGia.IdTacGia
    LEFT JOIN ChuongTruyen ON Truyen.IdTruyen = ChuongTruyen.IdTruyen
    GROUP BY Truyen.IdTruyen, Truyen.TenTruyen, Truyen.PhanMoTa, Truyen.AnhBia, Truyen.SLChuong, Truyen.SoLuotDanhGia, Truyen.SoLuotTheoDoi, Truyen.NgayDangTruyen, Truyen.IdTacGia, TacGia.TenTacGia
    ORDER BY Truyen.IdTruyen DESC;
END;

drop proc getcomicinfo

select * from TacGia

-- show comics' list of chapters
create proc listchapter_mainpage @id int
as
begin
	SELECT Truyen.*, ChuongTruyen.TenChuong, TacGia.TenTacGia
    FROM Truyen
    INNER JOIN TacGia ON Truyen.IdTacGia = TacGia.IdTacGia
    LEFT JOIN ChuongTruyen ON Truyen.IdTruyen = ChuongTruyen.IdTruyen
	WHERE ChuongTruyen.IdTruyen=@id
    GROUP BY Truyen.IdTruyen, Truyen.TenTruyen, Truyen.PhanMoTa, Truyen.AnhBia, Truyen.SLChuong, Truyen.SoLuotDanhGia, Truyen.SoLuotTheoDoi, Truyen.NgayDangTruyen, Truyen.IdTacGia, TacGia.TenTacGia, ChuongTruyen.TenChuong, TacGia.TenTacGia
end;

exec listchapter_mainpage @id = 2;

drop proc listchapter_mainpage

-- add comic
GO 
CREATE PROC addcomic
	@TenTruyen nvarchar(300),
	@PhanMoTa nvarchar(500),
	@AnhBia varchar(100),
	@IdTacGia INT
AS 
BEGIN 
	DECLARE @matruyen INT; 
	SELECT @matruyen=MAX(IdTruyen) FROM Truyen; 
	SET @matruyen=@matruyen+1; 
	INSERT INTO Truyen 
	VALUES(@matruyen,@TenTruyen,@PhanMoTa,@AnhBia,0,GETDATE(),0,0,@IdTacGia) 
END 

exec addcomic 'asd', 'asd', 'comin.jpg', '1'

drop proc addcomic

--delete comic
GO 
CREATE PROC DeleteComicById @ID INT 
AS 
BEGIN 
 DELETE FROM ChuongTruyen
 WHERE IdTruyen= @ID;

 DELETE FROM Truyen
WHERE IdTruyen = @ID;

DELETE FROM Truyen_TheLoai
WHERE IdTruyen = @ID;

END 

exec DeleteComicById 2

select * from truyen
select * from ChuongTruyen
select * from TheLoai
select * from Truyen_TheLoai

drop proc DeleteComicById

-- UPDATE COMIC
GO 
CREATE PROC updatecomic
	@TenTruyen nvarchar(300),
	@PhanMoTa nvarchar(500),
	@AnhBia varchar(100),
	@IdTacGia INT,
	@MaTruyen int
AS 
BEGIN 
	UPDATE Truyen 
	SET TenTruyen=@TenTruyen,  
		PhanMoTa=@PhanMoTa, 
		AnhBia=@AnhBia, 
		IdTacGia=@IdTacGia,
		NgayDangTruyen=Getdate()
    WHERE IdTruyen=@MaTruyen 
END 

drop proc updatecomic

--login
GO 
CREATE PROC checklogin @U VARCHAR(10),@P VARCHAR(10) 
AS 
BEGIN 
 Select *  
 from NguoiDung 
 Where Username=@U and Password=@P 
END 

exec checklogin 'user', 'user'

drop proc checklogin

--SIGNUP
GO 
CREATE PROC signupacc @U VARCHAR(10),@P VARCHAR(10), @E varchar(255)
AS 
BEGIN 
	DECLARE @userId INT, @userCount INT, @emailCount INT;
	SELECT @userCount = COUNT(*) FROM NguoiDung WHERE Username = @U;
    SELECT @emailCount = COUNT(*) FROM NguoiDung WHERE Email = @E;

    IF @userCount > 0
    BEGIN
        RAISERROR ('Tên người dùng đã tồn tại!', 16, 1);
		RETURN;
    END
    ELSE IF @emailCount > 0
    BEGIN
        RAISERROR ('Email đã sử dụng để đăng ký!', 16, 1);
		RETURN;
    END
	ELSE
	BEGIN
		SELECT @userId=MAX(IdUser) FROM NguoiDung; 
		SET @userId=@userId+1; 
		INSERT INTO NguoiDung 
		VALUES(@userId,@U,@P,@E,'User',0,0)
	END
END 

exec signupacc 'asd', 'asd', 'a@email.com'


--remove user
create proc removeuser @id int
as
begin
	delete from NguoiDung
	where IdUser = @id
end

drop proc removeuser


--add comic chapters
create proc addcomicchapter @Cname nvarchar(150), @R ntext, @idtruyen int
as
BEGIN 
	DECLARE @idchuong INT; 
	SELECT @idchuong=MAX(IdChuong) FROM ChuongTruyen; 
	SET @idchuong=@idchuong+1;

	INSERT INTO ChuongTruyen
	VALUES(@idchuong,@Cname,GETDATE(),@R,0,@idtruyen) 
END

drop proc addcomicchapter

exec addcomicchapter 

--update chapter
GO 
CREATE PROC updatechapter
	@Cname nvarchar(150),
	@R ntext,
	@idchuong int
AS 
BEGIN 
	UPDATE ChuongTruyen 
	SET TenChuong=@Cname,  
		NoiDungChuong=@R,
		NgayDangChuong=Getdate()
    WHERE IdChuong=@idchuong 
END 

drop proc updatechapter

--remove comic chapters
GO 
CREATE PROC removechapters @ID INT 
AS 
BEGIN 
 DELETE FROM ChuongTruyen 
 WHERE IdChuong=@ID 
END 

drop proc removechapters



-- find chapter info by id
create proc chapterinfo @id int
as
begin
	select * from ChuongTruyen left join truyen on Truyen.IdTruyen = ChuongTruyen.IdTruyen
	where @id=chuongtruyen.IdChuong
	order by ngaydangchuong desc
end;

exec chapterinfo '1'

drop proc chapterinfo

--show chapter
create proc showcomiclistofchapter @id int
as
begin
	select * from ChuongTruyen left join truyen on Truyen.IdTruyen = ChuongTruyen.IdTruyen
	where @id=ChuongTruyen.IdTruyen
end;

exec showcomiclistofchapter '2'

drop proc showcomiclistofchapter



--quanlytruyenchitiet
create proc QuanLyTruyenChiTiet @id int
as
begin
	SELECT Truyen.*, TacGia.TenTacGia
    FROM Truyen
    INNER JOIN TacGia ON Truyen.IdTacGia = TacGia.IdTacGia
    LEFT JOIN ChuongTruyen ON Truyen.IdTruyen = ChuongTruyen.IdTruyen
	where Truyen.IdTruyen = @id
    GROUP BY Truyen.IdTruyen, Truyen.TenTruyen, Truyen.PhanMoTa, Truyen.AnhBia, Truyen.SLChuong, Truyen.SoLuotDanhGia, Truyen.SoLuotTheoDoi, Truyen.NgayDangTruyen, Truyen.IdTacGia, TacGia.TenTacGia
    ORDER BY Truyen.IdTruyen DESC;
end;

exec QuanLyTruyenChiTiet '2' 

select * from Truyen

drop proc QuanLyTruyenChiTiet


--add genre
create proc addgenre @genre nvarchar(50)
as
BEGIN 
	DECLARE @id INT
	SELECT @id=MAX(IdTheLoai) FROM TheLoai; 
	SET @id=@id+1;

	INSERT INTO TheLoai
	VALUES(@id, @genre) 
END

drop proc addgenre


--update genre
GO 
CREATE PROC updategenre
	@genre nvarchar(50),
	@id int
AS 
BEGIN 
	UPDATE TheLoai 
	SET TenTheLoai=@genre
    WHERE IdTheLoai=@id 
END 

drop proc updategenre


--remove genre
GO 
CREATE PROC removegenre @ID INT 
AS 
BEGIN 
 DELETE FROM TheLoai 
 WHERE IdTheLoai=@ID 
END 

drop proc removegenre

select * from theloai


--show genre's list of comics
create proc showgenrelistofcomic @id int
as
begin
	select *
		from Truyen
		left join Truyen_TheLoai on Truyen.IdTruyen = Truyen_TheLoai.IdTruyen
		left join TheLoai on TheLoai.IdTheLoai = Truyen_TheLoai.IdTheLoai
		where TheLoai.IdTheLoai = @id
end

exec showgenrelistofcomic 3

drop proc showgenrelistofcomic

select * from theloai;

--quan ly the loai chi tiet
create proc quanlytheloaichitiet @id int
as
begin
	select * from TheLoai
	where @id=IdTheLoai
end;

exec quanlytheloaichitiet '2'

drop proc quanlytheloaichitiet


--profile
create proc profile_page @userid int
as
begin
	SELECT * FROM NguoiDung WHERE IdUser = @UserId
end

exec profile_page '1'



-- CHANGE CHAPTER
-- Lấy thông tin về chương trước
CREATE PROCEDURE GetPreviousChapter
    @CurrentChapterID INT,
    @TruyenID INT
AS
BEGIN
    SELECT TOP 1 * 
    FROM ChuongTruyen
    WHERE IdTruyen = @TruyenID AND IdChuong < @CurrentChapterID
    ORDER BY IdChuong DESC
END


drop proc GetPreviousChapter

-- Lấy thông tin về chương sau
CREATE PROCEDURE GetNextChapter
    @CurrentChapterID INT,
    @TruyenID INT
AS
BEGIN
    SELECT TOP 1 * 
    FROM ChuongTruyen
    WHERE IdTruyen = @TruyenID AND IdChuong > @CurrentChapterID
    ORDER BY IdChuong ASC
END


drop proc GetNextChapter


--read comic
create proc readcomic @id int
as
begin
	select * from ChuongTruyen
	where IdChuong = @id;
end

exec readcomic 2;

drop proc readcomic

----------------------------------------------------------------------------------




------------------------- KHÔNG CHẠY LỆNH DƯỚI NÀY --------------------------------------
select *
from chuongtruyen
where IdTruyen = 1 and idchuong <=
(select max(IdChuong)
from ChuongTruyen
where IdTruyen = 1)

--test
select * from NguoiDung

--hien chuong truyen trong chi tiet truyen
select * from Truyen inner join ChuongTruyen on Truyen.IdTruyen = ChuongTruyen.IdTruyen

select * from ChuongTruyen left join Truyen on Truyen.IdTruyen = ChuongTruyen.IdTruyen order by idchuong desc

select * from Truyen inner join TacGia on Truyen.IdTacGia = TacGia.IdTacGia

select * from ChuongTruyen inner join Truyen on Truyen.IdTruyen = ChuongTruyen.IdTruyen

select * from ChuongTruyen

select * from theloai;

select * from tacgia


	SELECT Truyen.*, TacGia.TenTacGia, COUNT(ChuongTruyen.TenChuong) AS SoLuongChuong
    FROM Truyen
    INNER JOIN TacGia ON Truyen.IdTacGia = TacGia.IdTacGia
    LEFT JOIN ChuongTruyen ON Truyen.IdTruyen = ChuongTruyen.IdTruyen
	where TacGia.IdTacGia = 2
    GROUP BY Truyen.IdTruyen, Truyen.TenTruyen, Truyen.PhanMoTa, Truyen.AnhBia, Truyen.SLChuong, Truyen.SoLuotDanhGia, Truyen.SoLuotTheoDoi, Truyen.NgayDangTruyen, Truyen.IdTacGia, TacGia.TenTacGia
    ORDER BY Truyen.IdTruyen DESC;



--ds truyen + tacgia + chuongtruyen
select *, (select COUNT(ChuongTruyen.TenChuong) from Truyen, ChuongTruyen where Truyen.IdTruyen = ChuongTruyen.IdTruyen group by Truyen.TenTruyen) from Truyen inner join TacGia on Truyen.IdTacGia = TacGia.IdTacGia order by IdTruyen desc



--GO 
--CREATE PROC signupacc @U VARCHAR(10),@P VARCHAR(10), @E varchar(255)
--AS 
--BEGIN 
--	DECLARE @userId INT
--	SELECT @userId=MAX(IdUser) FROM NguoiDung; 
--		SET @userId=@userId+1; 
--		INSERT INTO NguoiDung 
--		VALUES(@userId,@U,@P,@E,'User',0,0)
--END

--exec signupacc 'asd', 'asd', 'asd@email.com'

--drop proc signupacc



--delete NguoiDung
--where Username = 'a'

--select *
--from NguoiDung
