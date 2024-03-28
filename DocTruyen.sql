USE master
GO
DROP DATABASE QuanLyDocTruyen;
GO
create database QuanLyDocTruyen;
GO
use QuanLyDocTruyen;
GO

CREATE TABLE NguoiDung
(
  IdUser INT,
  Username varchar(10) NOT NULL,
  Password varchar(10) NOT NULL,
  Email varchar(255) NOT NULL,
  VaiTro nvarchar(15) NOT NULL,
  XemTruyenTheoDoi INT NOT NULL,
  XemTruyenDanhGia INT NOT NULL,
  PRIMARY KEY (IdUser)
);


CREATE TABLE TacGia
(
  IdTacGia INT,
  TenTacGia nvarchar(150) NOT NULL,
  PRIMARY KEY (IdTacGia)
);

CREATE TABLE TheLoai
(
  IdTheLoai INT,
  TenTheLoai nvarchar(50) NOT NULL,
  PRIMARY KEY (IdTheLoai)
);

CREATE TABLE Truyen
(
  IdTruyen INT,
  TenTruyen nvarchar(300) NOT NULL,
  PhanMoTa nvarchar(500),
  AnhBia varchar(100),
  SLChuong INT NOT NULL,
  NgayDangTruyen smalldatetime NOT NULL,
  SoLuotDanhGia INT NOT NULL,
  SoLuotTheoDoi INT NOT NULL,
  IdTacGia INT,
  PRIMARY KEY (IdTruyen),
  FOREIGN KEY (IdTacGia) REFERENCES TacGia(IdTacGia)
);

CREATE TABLE ChuongTruyen
(
  IdChuong INT,
  TenChuong nvarchar(150) NOT NULL,
  NgayDangChuong smalldatetime NOT NULL,
  NoiDungChuong ntext NOT NULL,
  LuotXemChuong INT NOT NULL,
  IdTruyen INT,
  PRIMARY KEY (IdChuong),
  FOREIGN KEY (IdTruyen) REFERENCES Truyen(IdTruyen)
);

CREATE TABLE BinhLuan
(
  IdBinhLuan INT,
  NoiDungBinhLuan ntext,
  NgayBinhLuan smalldatetime NOT NULL,
  IdUser INT,
  IdTruyen INT NOT NULL,
  PRIMARY KEY (IdBinhLuan),
  FOREIGN KEY (IdUser) REFERENCES NguoiDung(IdUser),
  FOREIGN KEY (IdTruyen) REFERENCES Truyen(IdTruyen)
);

CREATE TABLE Truyen_TheLoai
(
  IdTruyen_TheLoai INT,
  IdTruyen INT,
  IdTheLoai INT,
  PRIMARY KEY (IdTruyen_TheLoai),
  FOREIGN KEY (IdTruyen) REFERENCES Truyen(IdTruyen),
  FOREIGN KEY (IdTheLoai) REFERENCES TheLoai(IdTheLoai)
);



CREATE TABLE LuotThich
(
  IdLuotThich INT,
  IdUser INT,
  IdTruyen INT NOT NULL,
  PRIMARY KEY (IdLuotThich),
  FOREIGN KEY (IdUser) REFERENCES NguoiDung(IdUser),
  FOREIGN KEY (IdTruyen) REFERENCES Truyen(IdTruyen)
);
GO

drop table NguoiDung
drop table TacGia
drop table TheLoai
drop table Truyen
drop table ChuongTruyen
drop table BinhLuan
drop table Truyen_TheLoai
drop table LuotThich

---------------------NHAP LIEU---------------------

INSERT INTO NguoiDung VALUES
(1, 'admin', 'admin', 'admin@email.com', 'Admin', 0, 0),
(2, 'user', 'user', 'user@email.com', 'User', 0, 0);
go

INSERT INTO TacGia VALUES
(1, N'Đông Thiên Đích Liễu Diệp');
go

INSERT INTO TheLoai VALUES
(1, N'Ngôn tình'),
(2, N'Cổ đại'),
(3, N'Trọng sinh');
go

INSERT INTO Truyen VALUES
(1, N'Tự Cẩm', N'Trong kinh thành mọi người đều đồn đại rằng ở trong Khương gia thì Tứ tiểu thư nổi tiếng là một đại tuyệt sắc mỹ nhân. Nhưng đáng tiếc là đáng tiếc lúc nàng xinh đẹp nhất lại bị phủ An quốc công chọn trúng. Không chỉ vậy mà đêm trước khi Khương Tự xuất giá, vị hôn phu cùng nữ nhân khác nhảy sông tự tử...',
'tucam.jpg', 0, CAST(0x950A0000 AS SmallDateTime), 0, 0, 1);
go

INSERT INTO ChuongTruyen VALUES
(1, N'Chương 1: Đêm', CAST(0x950A0000 AS SmallDateTime), N'</div><p>" Cô nương, đã đến giữa giờ Tuất rồi. " Tỳ nữ A Man đi vào trong phòng, nhấc màn lụa màu xanh mưa trời treo lên móc giá trên giường, nhẹ giọng gọi thiếu nữ nằm nghiêng trên giường.</p><p><br></p><p>Lúc này đã là đầu hạ, bên ngoài trời vừa mới hoàn toàn tối xuống, bóng đêm mờ ảo bao phủ khuôn mặt của thiếu nữ, mượn ánh nến trên bàn, lờ mờ có thể thấy rõ diện mạo của thiếu nữ trong trướng.</p><p><br></p><p>Thiếu nữ lông mày như núi xa, mũi ngọc tinh xảo môi anh đào, má đào da tuyết, đúng là một tiểu mỹ nhân đẹp xuất sắc.</p><p><br></p><p>Thiếu nữ chính là cô nương đứng hàng thứ tư của Đông Bình Bá phủ Khương gia, tên chỉ một chữ Tự .</p><p><br></p><p>A Man thấy dáng vẻ của Khương Tự, trong lòng liền dâng lên một cơn lửa giận, bất bình thay cho cô nương nhà mình.</p><p><br></p><p>Vị Tam công tử của An quốc công phủ hẳn là mắt bị mù rồi, bằng vào diện mạo của cô nương tiến cung làm nương nương cũng được, ấy thế mà hắn lại không thấy thích thú cửa hôn sự này, chẳng lẽ cảm thấy cô nương không xứng với hắn ư?</p><p><br></p><p>Lửa giận của A Man bắt nguồn từ một buổi hội thơ ngày xuân.</p><p><br></p><p>Hội thơ đó là do một ít danh môn công tử trong kinh tổ chức, đơn giản chính là một ít người trẻ tuổi tụ tập với nhau uống rượu ngâm thơ tìm niềm vui, đến khi rượu đã hơi ngà say, liền có người bắt đầu trêu chọc Tam công tử Quý Sùng Dịch của An Quốc Công phủ, trong ngôn ngữ có phần ghen tị hắn sắp được thành hôn với tiểu mỹ nhân nổi danh trong kinh.</p><p><br></p><p>Ai ngờ Quý Sùng Dịch mang theo men say tự giễu cười một tiếng, nói câu: " Đẹp thì thế nào , chẳng qua cũng chỉ là một bộ túi da thôi, nữ tử bây giờ lấy phẩm tính ôn nhu lương thiện làm trọng."</p><p><br></p><p>Vốn là lời say của người trẻ tuổi, nghe một chút cũng liền qua đi, tỉnh rượu rồi tự nhiên như gió thoảng không dấu vết, ai ngờ lời này không biết làm sao lại truyền ra ngoài, Tứ cô nương của Khương gia lập tức trở thành trò cười của mọi người trong lúc uống trà ẩm rượu.</p><p><br></p><p>Đông Bình Bá phủ vốn căn cơ nông cạn, tước vị chỉ có thể kế tục ba đời, đến thế hệ phụ thân của Khương Tự là Đông Bình Bá đã là ba đời, vì lẽ đó mà huynh trưởng của Khương Tự ngay cả thế tử cũng chưa được xin phong.</p><p><br></p><p>Nói cách khác, sau trăm năm nữa, Đông Bình Bá phủ sẽ từ trong vòng luẩn quẩn huân quý lui ra ngoài, trở thành người bình thường.</p><p><br></p><p>Chính là cô nương một nhà như vậy, lại đã đính hôn với An Quốc Công phủ, trước không nói đến cơ duyên trong đó, thì điều này cũng đủ để khiến rất nhiều người nhìn không vừa mắt với Khương Tự trèo cao lên An Quốc Công phủ.</p><p><br></p><p>Tam công tử Quý Sùng Dịch của An Quốc Công phủ nói nữ tử mỹ mạo không quan trọng, hắn coi trọng tính tình hơn, cái này ngụ ý, còn không phải chính là ghét bỏ Khương Tứ cô nương tính tình không tốt sao?</p><p><br></p><p>Vô luận Quý Sùng Dịch nói lời này là hữu tâm hay là vô tình, thì lời này vừa truyền ra lập tức khiến Khương Tự mất hết mặt mũi, lại ra ngoài tham gia tụ hội của nhóm quý nữ, liền nghe được một bụng lời đàm tiếu.</p><p><br></p><p>Khương Tự là một người nóng tính, trở về liền đổ bệnh, vừa bệnh chính là nửa tháng.</p><p><br></p><p>Khương Tự nằm ở trên giường nhắm mắt dưỡng thần bỗng nhiên mở mắt ra.</p><p><br></p><p>Đôi mắt của nàng đường cong cực đẹp, đến đuôi mắt hơi nhếch lên, phác hoạ ra nét phong lưu diễm lệ khó mà diễn tả bằng lời.</p><p><br></p><p>Lúc này hai con ngươi cực đẹp đối diện với A Man, lộ ra ý cười mờ nhạt: " Bày ra dáng vẻ muốn ăn thịt người thế làm gì?"</p><p><br></p><p>" Nghĩ đến người nào đó có mắt không tròng, nô tỳ liền thấy tức thay cô nương."</p><p><br></p><p>Ý cười nơi đáy mắt của Khương Tự nhanh chóng mất đi, độ cong khóe miệng lại sâu hơn, thản nhiên nói: " Người đó còn chưa từng gặp ta, không thể nói là có mắt không tròng."</p><p><br></p><p>" Cô nương, người còn nói đỡ cho hắn nữa! " Nhìn cô nương chỉ mới nửa tháng ngắn ngủi đã gầy đi một vòng, A Man liền thấy đau lòng cùng không phục.</p><p><br></p><p>Nửa tháng trước cô nương đi Phó Vĩnh Xương Bá phủ ngắm hoa yến trở về liền khóc lớn một trận, ngay cả vật trang trí Ngọc Tỳ Hưu yêu thích nhất cũng đập vỡ, nhắc đến Tam công tử của An Quốc Công phủ càng hận đến nghiến răng nghiến lợi, sao bây giờ lại thay đổi rồi?</p><p><br></p><p>" Không phải nói đỡ cho hắn, một câu nói say thôi mà". Khương Tự chuyển mắt, nhìn về phía một tỳ nữ khác đứng ở cạnh bình phong A Xảo, phân phó nói, " A Xảo, đi lấy hai bộ y phục mấy ngày trước kêu ngươi làm ra đây đi."</p><p><br></p><p>Không bao lâu A Xảo nâng đến hai bộ y phục, trong đó một bộ cho A Man, một bộ khác thì hầu hạ Khương Tự mặc vào.</p><p><br></p><p>A Man vừa mặc bộ y phục lên người vừa căm giận nói: " Một câu lời say mà làm hại cô nương bị người ta chê cười đấy."</p><p><br></p><p>Đáy mắt Khương Tự ý lạnh sâu hơn, dứt khoát nhắm lại con ngươi, nói khẽ: " Đây được tính là gì?"</p><p><br></p><p>Nàng bất hạnh cả đời, chính là bắt đầu từ cuộc hôn nhân môn không đăng hộ không đối này.</p><p><br></p><p>Nhớ khi đó, tuổi trẻ vô tri, nàng là cỡ nào đắc ý vì có thể đính hôn với công tử của An Quốc Công phủ, ai ngờ vị Tam công tử Quý Sùng Dịch đó đã sớm có người trong lòng.</p><p><br></p><p>Người trong lòng Quý Sùng Dịch là một vị dân nữ.</p><p><br></p><p>Nàng gả qua rồi sau đó mới dần dần biết được, vị dân nữ đó cơ duyên xảo hợp cứu được Quý Sùng Dịch đi ra ngoài du ngoạn gặp nạn, Quý Sùng Dịch ở trong nhà nữ tử đó dưỡng thương mấy ngày mới được Quốc Công phủ tìm thấy, hai người đã nảy sinh tình cảm, sau đó vẫn luôn vụng trộm qua lại.</p><p><br></p><p>Mà trong lúc nàng còn tràn ngập khát khao cùng đắc ý với đoạn hôn nhân này, thì Quý Sùng Dịch vì có thể cùng người trong lòng ở bên nhau mà đã rất nhiều lần phản kháng trưởng bối trong nhà.</p><p><br></p><p>Hôn sự đã gần ngay trước mắt, An Quốc Công phủ đương nhiên không cho phép Quý Sùng Dịch nháo loạn, huống chi hắn muốn cưới chính là nữ tử bình dân ngay cả Khương gia cũng không bằng, Quý Sùng Dịch phản kháng cùng bất mãn tự nhiên không hề có chút tác dụng nào.</p><p><br></p><p>Khương Tự nghĩ đến câu nói lúc say rượu của Quý Sùng Dịch, liền cảm thấy khi đó mình thật ngu xuẩn, tức giận qua đi lại nhịn không được thay hắn tìm lý do, cho là hắn không để ý thế tục, không phải như những nam tử dung tục chỉ để ý dung mạo của nữ tử, nói câu nói kia chỉ là việc nào ra việc đó thôi.</p><p><br></p><p>Qua việc nào ra việc đó của hắn, ngay tại đêm nay, tối mười lăm tháng tư năm mười tám Cảnh Minh, vị quý công tử danh môn không để ý thế tục này lại cùng người trong lòng cùng nhau chạy đến ven hồ Mạc Ưu, nhảy hồ tự vẫn.</p><p><br></p><p>Sau đó Quý Sùng Dịch được cứu lên, người trong lòng của hắn lại hương tiêu ngọc vẫn.</p><p><br></p><p>Vì che lấp chuyện này, hôn sự mà bọn họ vốn định vào đầu mùa đông tự nhiên lại tổ chức trước thời hạn mấy tháng, mà từ sau khoảng thời gian nàng lòng tràn đầy vui vẻ gả qua cho đến khi Quý Sùng Dịch ngoài ý muốn bỏ mình, thì trong gần một năm thời gian đó, người nam nhân như ánh trăng sáng này đều chưa từng chạm vào nàng.</p><p><br></p><p>Rồi sau đó, càng nhiều biến cố xảy ra hơn, cho đến khi nàng chết thảm rồi lại mở mắt ra, về lại năm mười lăm tuổi này.</p><p><br></p><p>Có thể nói, tất cả mọi bất hạnh của nàng đều bắt đầu từ lúc gả cho Quý Sùng Dịch, mà bây giờ có thể làm lại lần nữa, việc cấp bách của nàng chính là giải quyết cọc hôn sự này, từ đây phân rõ giới hạn với quý Tam công tử không lưu thế tục, với An Quốc Công phủ cao không thể chạm, cả đời không bao giờ qua lại với nhau nữa!</p><p><br></p><p>Trong khoảnh khắc Khương Tự đã mặc xong y phục rồi ra ngoài, gật đầu với A Man: " A Man, đi thôi."</p><p><br></p><p>A Man đem tay nải đặt ở trên ghế xách lên.</p><p><br></p><p>A Xảo do dự một chút, ngăn lại Khương Tự rồi chần chừ nói: " Cô nương, đã trễ thế này, cô nương thật sự muốn đi ra ngoài sao? Chỗ nhị môn đã khóa rồi--"</p><p><br></p><p>" Không sao, những cái đó đều chuẩn bị xong cả rồi. A Xảo, ngươi trông coi sân viện cho tốt là được." Khương Tự nét mặt kiên quyết.</p><p><br></p><p>Nếu như có thể, nàng đương nhiên không muốn đêm khuya đi ra ngoài mạo hiểm, nhưng mà hiện giờ trong phủ ngoại trừ hai thiếp thân nha hoàn, thì nàng cũng không tìm thấy người nào có thể tin được để hỗ trợ cả.</p><p><br></p><p>A Xảo thấy vậy đành phải gật đầu thật mạnh, nói một tiếng " cô nương yên tâm", rồi tránh đường.</p><p><br></p><p>Khương Tự mang theo A Man lặng lẽ ra khỏi Hải Đường Cư chỗ ở của nàng, mượn trăm hoa tươi tốt che lấp xuyên qua vườn hoa cùng trùng trùng cổng vòm, đi vào nhị môn.</p><p><br></p><p>" Cô nương -- " A Man nhìn cánh cửa đóng chặt, thấp giọng gọi một tiếng.</p></div>', 0, 1);
go

INSERT INTO Truyen_TheLoai VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 2, 4)
go


select * from chuongtruyen
delete chuongtruyen where idchuong = 3 or idchuong = 2


select * from truyen

select * from truyen left join ChuongTruyen on Truyen.IdTruyen = ChuongTruyen.IdTruyen

select * from ChuongTruyen left join truyen on Truyen.IdTruyen = ChuongTruyen.IdTruyen