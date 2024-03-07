-- Tim truyen
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

EXEC findcomicbyid @ID = 3; -- Thay 123 bằng giá trị ID mong muốn


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

-- HIỆN DANH SÁCH CHƯƠNG
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

exec listchapter_mainpage @id = 1;

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

--xoa comic
GO 
CREATE PROC DeleteComicById @ID INT 
AS 
BEGIN 
 DELETE FROM Truyen 
 WHERE IdTruyen=@ID 
END 

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

----------------------------------------------------------------------------------

GO 
CREATE PROC signupacc @U VARCHAR(10),@P VARCHAR(10), @E varchar(255)
AS 
BEGIN 
	DECLARE @userId INT
	SELECT @userId=MAX(IdUser) FROM NguoiDung; 
		SET @userId=@userId+1; 
		INSERT INTO NguoiDung 
		VALUES(@userId,@U,@P,@E,'User',0,0)
END

exec signupacc 'asd', 'asd', 'asd@email.com'

drop proc signupacc



delete NguoiDung
where Username = 'a'

select *
from NguoiDung


-------------------------------------------------------------------------------------------------
create proc QuanLyTruyenChiTiet @id int
as
begin
	SELECT Truyen.*, TacGia.TenTacGia, COUNT(ChuongTruyen.TenChuong) AS SoLuongChuong
    FROM Truyen
    INNER JOIN TacGia ON Truyen.IdTacGia = TacGia.IdTacGia
    LEFT JOIN ChuongTruyen ON Truyen.IdTruyen = ChuongTruyen.IdTruyen
	where @id=Truyen.IdTruyen
    GROUP BY Truyen.IdTruyen, Truyen.TenTruyen, Truyen.PhanMoTa, Truyen.AnhBia, Truyen.SLChuong, Truyen.SoLuotDanhGia, Truyen.SoLuotTheoDoi, Truyen.NgayDangTruyen, Truyen.IdTacGia, TacGia.TenTacGia
    ORDER BY Truyen.IdTruyen DESC
end;

exec QuanLyTruyenChiTiet '2'

drop proc QuanLyTruyenChiTiet


------------------------- KHÔNG CHẠY LỆNH DƯỚI NÀY --------------------------------------
--test

--hien chuong truyen trong chi tiet truyen
select * from Truyen inner join ChuongTruyen on Truyen.IdTruyen = ChuongTruyen.IdTruyen

select * from Truyen inner join TacGia on Truyen.IdTacGia = TacGia.IdTacGia

select * from ChuongTruyen inner join Truyen on Truyen.IdTruyen = ChuongTruyen.IdTruyen


--ds truyen + tacgia + chuongtruyen
select *, (select COUNT(ChuongTruyen.TenChuong) from Truyen, ChuongTruyen where Truyen.IdTruyen = ChuongTruyen.IdTruyen group by Truyen.TenTruyen) from Truyen inner join TacGia on Truyen.IdTacGia = TacGia.IdTacGia order by IdTruyen desc


