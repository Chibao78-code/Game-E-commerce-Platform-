/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  LENOVO
 * Created: Feb 25, 2025
 */
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates.
 * and open the template in the editor.
 */
/**
 * Author:  LENOVO
 * Created: Feb 25, 2025
 */
DROP TABLE tblUsers
DROP TABLE tblGames
DROP TABLE tblOrders
CREATE DATABASE Muabangame_com;
USE Muabangame_com;

CREATE TABLE tblGames (
    game_id      INT PRIMARY KEY IDENTITY(1,1),
    game_name    NVARCHAR(255) NOT NULL,
    price        DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    release_date DATE,
    genre        NVARCHAR(100),
    platform     NVARCHAR(100),
    description  NVARCHAR(MAX),
    stock        INT DEFAULT 0 CHECK (stock >= 0),
    image_url    NVARCHAR(255),
    created_at   DATETIME DEFAULT GETDATE(),
    updated_at   DATETIME DEFAULT GETDATE()
);

CREATE TABLE tblUsers (
    user_id    INT PRIMARY KEY IDENTITY(1,1),
    username   NVARCHAR(255) NOT NULL UNIQUE,
	fullname   NVARCHAR(255) NOT NULL,
    password   NVARCHAR(255) NOT NULL,
    email      NVARCHAR(255) NOT NULL UNIQUE,
    phone      NVARCHAR(20),
    address    NVARCHAR(255),
    role       NVARCHAR(20) DEFAULT 'Customer' CHECK(role IN ('Customer', 'Admin')),
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE tblOrders (
    order_id    INT PRIMARY KEY IDENTITY(1,1),
    user_id     INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price >= 0),
    status      NVARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'completed', 'canceled')),
    created_at  DATETIME DEFAULT GETDATE(),
    updated_at  DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES tblUsers(user_id) ON DELETE CASCADE
);

CREATE TABLE tblOrderDetails (
    order_detail_id INT PRIMARY KEY IDENTITY(1,1),
    order_id        INT NOT NULL,
    game_id         INT NOT NULL,
    quantity        INT NOT NULL CHECK (quantity > 0),
    price          DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    total_price    AS (quantity * price) PERSISTED,
    FOREIGN KEY (order_id) REFERENCES tblOrders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES tblGames(game_id) ON DELETE CASCADE
);

CREATE TABLE tblPayments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    order_id   INT NOT NULL,
    user_id    INT NOT NULL,
    amount     DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    method     NVARCHAR(50) NOT NULL CHECK (method IN ('credit_card', 'paypal', 'bank_transfer')),
    status     NVARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'failed')),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES tblOrders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES tblUsers(user_id) ON DELETE CASCADE
);

CREATE TABLE tblReviews (
    review_id  INT PRIMARY KEY IDENTITY(1,1),
    game_id    INT NOT NULL,
    user_id    INT NOT NULL,
    rating     INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment    NVARCHAR(1000),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (game_id) REFERENCES tblGames(game_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES tblUsers(user_id) ON DELETE CASCADE
);

CREATE TABLE tblCart (
    cart_id  INT PRIMARY KEY IDENTITY(1,1),
    user_id  INT NOT NULL,
    game_id  INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES tblUsers(user_id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES tblGames(game_id) ON DELETE CASCADE
);

CREATE TABLE tblDiscounts (
    discount_id      INT PRIMARY KEY IDENTITY(1,1),
    game_id          INT NOT NULL,
    discount_percent DECIMAL(5,2) NOT NULL CHECK (discount_percent BETWEEN 0 AND 100),
    start_date       DATE NOT NULL,
    end_date         DATE NOT NULL,
    FOREIGN KEY (game_id) REFERENCES tblGames(game_id) ON DELETE CASCADE
);

CREATE TABLE tblWishlists (
    wishlist_id INT PRIMARY KEY IDENTITY(1,1),
    user_id     INT NOT NULL,
    game_id     INT NOT NULL,
    added_at    DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES tblUsers(user_id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES tblGames(game_id) ON DELETE CASCADE
);

CREATE TABLE tblGenres (
    genre_id INT PRIMARY KEY IDENTITY(1,1),
    genre_name VARCHAR(50) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE tblGameGenres (
    game_id INT,
    genre_id INT,
    PRIMARY KEY (game_id, genre_id),
    FOREIGN KEY (game_id) REFERENCES tblGames(game_id),
    FOREIGN KEY (genre_id) REFERENCES tblGenres(genre_id)
);

-- Danh sách Admin
INSERT INTO tblUsers (fullname, username, password, email, phone, address, role)
VALUES 
('Ly Anh Khoa', 'admin012', 'admin012', 'anhkhoa14155@gmail.com', '0905123456', '123 Le Loi, Quan 1, TP.HCM', 'Admin'),
('Phạm Duc Thanh Phuong', 'admin123', 'admin123', 'phamphuong2910vn@gmail.com', '0909988776', '654 Vo Thi Sau, Quan 1, TP.HCM', 'Admin'),
('Nguyen Hoang Bao Thy', 'admin456', 'admin456', 'nguyenhoangbaothy0104@gmail.com', '0938761234', '34 Phan Dang Luu, Quan Binh Thanh, TP.HCM', 'Admin');


-- Danh sách Customer
INSERT INTO tblUsers (fullname, username, password, email, phone, address, role)
VALUES 
('Tran Thi Bich', 'U002', '87654321', 'tranthibich@outlook.com', '0912345678', '456 Hai Ba Trung, Quan 3, TP.HCM', 'Customer'),
('Le Van Cuong', 'U003', 'password123', 'levancuong@gmail.com', '0932123456', '789 Cach Mang Thang 8, Quan 10, TP.HCM', 'Customer'),
('Pham Thi Dao', 'U004', 'mypassword', 'phamthidao@outlook.com', '0987456123', '321 Nguyen Trai, Quan 5, TP.HCM', 'Customer'),
('Bui Thi Hoa', 'U006', 'hoa12345', 'buithihoa@outlook.com', '0978654321', '12 Nguyen Hue, Quan 1, TP.HCM', 'Customer'),
('Hoang Van Khoa', 'U007', 'khoa9876', 'hoangvankhoa@gmail.com', '0967345678', '78 Tran Hung Dao, Quan 5, TP.HCM', 'Customer'),
('Nguyen Thi Lan', 'U008', 'lanlan123', 'nguyenthilan@outlook.com', '0945236789', '98 Ly Thuong Kiet, Quan 10, TP.HCM', 'Customer'),
('Dang Thi Mai', 'U010', 'mai45678', 'dangthimai@outlook.com', '0923456781', '56 Nguyen Dinh Chieu, Quan 3, TP.HCM', 'Customer');

--Gamme
INSERT INTO tblGames (game_name, price, release_date, genre, platform, description, stock, image_url)
VALUES
('The Witcher 3: Wild Hunt', 39.99, '2015-05-19', 'RPG', 'PC, PS4, Xbox One, Switch', 'An open-world RPG with a gripping story.', 50, 'https://example.com/witcher3.jpg'),
('Cyberpunk 2077', 59.99, '2020-12-10', 'Action RPG', 'PC, PS5, Xbox Series X', 'A futuristic open-world RPG.', 40, 'https://example.com/cyberpunk2077.jpg'),
('Red Dead Redemption 2', 49.99, '2018-10-26', 'Action-Adventure', 'PC, PS4, Xbox One', 'An epic Western adventure.', 30, 'https://example.com/rdr2.jpg'),
('God of War', 49.99, '2018-04-20', 'Action', 'PS4, PC', 'Kratos returns in a Norse mythology setting.', 25, 'https://example.com/godofwar.jpg'),
('Elden Ring', 59.99, '2022-02-25', 'RPG', 'PC, PS5, Xbox Series X', 'An open-world soulslike RPG.', 45, 'https://example.com/eldenring.jpg'),
('Horizon Zero Dawn', 29.99, '2017-02-28', 'Action RPG', 'PC, PS4', 'A sci-fi action RPG with robotic creatures.', 20, 'https://example.com/horizonzerodawn.jpg'),
('Assassin''s Creed Valhalla', 39.99, '2020-11-10', 'Action RPG', 'PC, PS5, Xbox Series X', 'A Viking-era Assassin''s Creed game.', 35, 'https://example.com/acvalhalla.jpg'),
('The Legend of Zelda: Breath of the Wild', 49.99, '2017-03-03', 'Action-Adventure', 'Switch', 'An open-world Zelda adventure.', 50, 'https://example.com/zelda_botw.jpg'),
('Super Mario Odyssey', 49.99, '2017-10-27', 'Platformer', 'Switch', 'A 3D Mario adventure.', 45, 'https://example.com/supermarioodyssey.jpg'),
('Dark Souls III', 39.99, '2016-04-12', 'RPG', 'PC, PS4, Xbox One', 'A challenging action RPG.', 30, 'https://example.com/darksouls3.jpg'),
('Bloodborne', 29.99, '2015-03-24', 'Action RPG', 'PS4', 'A gothic horror soulslike.', 25, 'https://example.com/bloodborne.jpg'),
('Doom Eternal', 39.99, '2020-03-20', 'Shooter', 'PC, PS4, Xbox One', 'A fast-paced demon-slaying shooter.', 20, 'https://example.com/doometernal.jpg'),
('Resident Evil Village', 49.99, '2021-05-07', 'Survival Horror', 'PC, PS5, Xbox Series X', 'A horror survival game with vampires and werewolves.', 30, 'https://example.com/re8.jpg'),
('Sekiro: Shadows Die Twice', 39.99, '2019-03-22', 'Action RPG', 'PC, PS4, Xbox One', 'A samurai-themed action RPG.', 25, 'https://example.com/sekiro.jpg'),
('Ghost of Tsushima', 49.99, '2020-07-17', 'Action', 'PS4', 'A samurai open-world adventure.', 30, 'https://example.com/ghostoftsushima.jpg'),
('Minecraft', 29.99, '2011-11-18', 'Sandbox', 'PC, Consoles, Mobile', 'A block-building sandbox game.', 100, 'https://example.com/minecraft.jpg'),
('Grand Theft Auto V', 29.99, '2013-09-17', 'Action-Adventure', 'PC, PS5, Xbox Series X', 'A crime-filled open-world game.', 75, 'https://example.com/gta5.jpg'),
('The Last of Us Part II', 49.99, '2020-06-19', 'Action-Adventure', 'PS4', 'A post-apocalyptic narrative-driven game.', 30, 'https://example.com/tlou2.jpg'),
('Metal Gear Solid V: The Phantom Pain', 29.99, '2015-09-01', 'Stealth', 'PC, PS4, Xbox One', 'A tactical espionage open-world game.', 20, 'https://example.com/mgs5.jpg'),
('Overwatch 2', 0.00, '2022-10-04', 'Shooter', 'PC, Consoles', 'A team-based multiplayer shooter.', 150, 'https://example.com/overwatch2.jpg'),
('Fortnite', 0.00, '2017-07-25', 'Battle Royale', 'PC, Consoles, Mobile', 'A popular battle royale game.', 200, 'https://example.com/fortnite.jpg'),
('League of Legends', 0.00, '2009-10-27', 'MOBA', 'PC', 'A competitive multiplayer battle arena game.', 250, 'https://example.com/lol.jpg'),
('Counter-Strike: Global Offensive', 0.00, '2012-08-21', 'Shooter', 'PC', 'A competitive tactical shooter.', 300, 'https://example.com/csgo.jpg'),
('Dota 2', 0.00, '2013-07-09', 'MOBA', 'PC', 'A complex strategy game.', 200, 'https://example.com/dota2.jpg'),
('Valorant', 0.00, '2020-06-02', 'Shooter', 'PC', 'A tactical team-based FPS.', 180, 'https://example.com/valorant.jpg'),
('Halo Infinite', 59.99, '2021-12-08', 'Shooter', 'PC, Xbox Series X', 'A sci-fi FPS with multiplayer and campaign.', 30, 'https://example.com/haloinfinite.jpg'),
('Starfield', 69.99, '2023-09-06', 'RPG', 'PC, Xbox Series X', 'A space-exploration RPG by Bethesda.', 40, 'https://example.com/starfield.jpg'),
('Baldur''s Gate 3', 59.99, '2023-08-03', 'RPG', 'PC, PS5', 'A D&D-inspired turn-based RPG.', 50, 'https://example.com/baldursgate3.jpg'),
('Dead Space Remake', 59.99, '2023-01-27', 'Survival Horror', 'PC, PS5, Xbox Series X', 'A sci-fi horror remake.', 25, 'https://example.com/deadspace.jpg'),
('Diablo IV', 69.99, '2023-06-06', 'Action RPG', 'PC, PS5, Xbox Series X', 'A dark fantasy hack-and-slash RPG.', 35, 'https://example.com/diablo4.jpg');


--Update lại image_url
UPDATE games SET image_url = 'assets/image/Games/The Witcher 3 Wild Hunt/thewitcher3.jpeg' WHERE id = 1;
UPDATE games SET image_url = 'assets/image/Games/Cyberpunk 2077/c9s2kycuqxc91.jpg' WHERE id = 2;
UPDATE games SET image_url = 'assets/image/Games/Red Dead Redemption 2/ReddeadRedemptionII.jpeg' WHERE id = 3;
UPDATE games SET image_url = 'assets/image/Games/God of War/steel-magnolia-15owu.jpg' WHERE id = 4;
UPDATE games SET image_url = 'assets/image/Games/Elden Ring/EldenRing.jpeg' WHERE id = 5;
UPDATE games SET image_url = 'assets/image/Games/Horizon Zero Dawn/HorizonZeroDawn.jpg' WHERE id = 6;
UPDATE games SET image_url = 'assets/image/Games/Assassin''s Creed Valhalla/Assassin''s_Creed_Valhalla_cover.jpg' WHERE id = 7;
UPDATE games SET image_url = 'assets/image/Games/The Legend of Zelda Breath of the Wild/legendofzelda.jpeg' WHERE id = 8;
UPDATE games SET image_url = 'assets/image/Games/Super Mario Odyssey/superMario.jpeg' WHERE id = 9;
UPDATE games SET image_url = 'assets/image/Games/Dark Souls III/darksoulIII.jpg' WHERE id = 10;
UPDATE games SET image_url = 'assets/image/Games/Bloodborne/KKLEVc2SIIgrFVjsZChZJk1d.jpg' WHERE id = 11;
UPDATE games SET image_url = 'assets/image/Games/Doom Eternal/DoomEternal.jpeg' WHERE id = 12;
UPDATE games SET image_url = 'assets/image/Games/Resident Evil Village/ResidentEvil.jpeg' WHERE id = 13;
UPDATE games SET image_url = 'assets/image/Games/Sekiro Shadows Die Twice/Sekiro.jpeg' WHERE id = 14;
UPDATE games SET image_url = 'assets/image/Games/Ghost of Tsushima/Ghostofstushima.jpeg' WHERE id = 15;
UPDATE games SET image_url = 'assets/image/Games/Minecraft/minecraft-java-bedrock-edition-for-pc.jpg' WHERE id = 16;
UPDATE games SET image_url = 'assets/image/Games/GTAV/Grand-Theft-Auto-V.jpg' WHERE id = 17;
UPDATE games SET image_url = 'assets/image/Games/The Last of Us Part II/capsule_616x353.jpg' WHERE id = 18;
UPDATE games SET image_url = 'assets/image/Games/Metal Gear Solid V The Phantom Pain/91ccdImKZUL.jpg' WHERE id = 19;
UPDATE games SET image_url = 'assets/image/Games/Overwatch 2/OverWatch.jpg' WHERE id = 20;
UPDATE games SET image_url = 'assets/image/Games/Fortnite/fornite.jpeg' WHERE id = 21;
UPDATE games SET image_url = 'assets/image/Games/League of Legends/LOL.jpeg' WHERE id = 22;
UPDATE games SET image_url = 'assets/image/Games/Counter-Strike Global Offensive/Counter-Strike_Global_Offensive_poster.jpg' WHERE id = 23;
UPDATE games SET image_url = 'assets/image/Games/Dota2/Dota2.jpeg' WHERE id = 24;
UPDATE games SET image_url = 'assets/image/Games/Valorant/valorant.jpeg' WHERE id = 25;
UPDATE games SET image_url = 'assets/image/Games/Halo Infinite/HaloInfinite.jpeg' WHERE id = 26;
UPDATE games SET image_url = 'assets/image/Games/Starfield/startfield.jpeg' WHERE id = 27;
UPDATE games SET image_url = 'assets/image/Games/Baldur''s Gate 3/bardur_gate3.jpeg' WHERE id = 28;
UPDATE games SET image_url = 'assets/image/Games/Dead Space Remake/DeadSpaceRemake.jpeg' WHERE id = 29;
UPDATE games SET image_url = 'assets/image/Games/Diablo IV/DiabloIV.jpeg' WHERE id = 30;

ALTER TABLE [dbo].[tblUsers]
ALTER COLUMN [password] [varchar](250) NOT NULL;



SELECT genre_name 
FROM tblGenres;


-- Xóa dữ liệu cũ
DELETE FROM tblGenres;

-- Chèn lại dữ liệu
INSERT INTO tblGenres (genre_name)
VALUES 
    ('Action'),
    ('RPG'),
    ('Adventure'),
    ('Shooter'),
    ('Action RPG'),
    ('Action-Adventure'),
    ('Platformer'),
    ('Survival Horror'),
    ('Sandbox'),
    ('Stealth'),
    ('Battle Royale'),
    ('MOBA');

	INSERT INTO tblGameGenres (game_id, genre_id)
VALUES
(1, 23),  -- The Witcher 3: Wild Hunt -> RPG (genre_id = 23)
(2, 26),  -- Cyberpunk 2077 -> Action RPG (genre_id = 26)
(3, 27),  -- Red Dead Redemption 2 -> Action-Adventure (genre_id = 27)
(4, 22),  -- God of War -> Action (genre_id = 22)
(5, 23),  -- Elden Ring -> RPG (genre_id = 23)
(6, 26),  -- Horizon Zero Dawn -> Action RPG (genre_id = 26)
(7, 26),  -- Assassin's Creed Valhalla -> Action RPG (genre_id = 26)
(8, 27),  -- The Legend of Zelda: Breath of the Wild -> Action-Adventure (genre_id = 27)
(9, 28),  -- Super Mario Odyssey -> Platformer (genre_id = 28)
(10, 23), -- Dark Souls III -> RPG (genre_id = 23)
(11, 26), -- Bloodborne -> Action RPG (genre_id = 26)
(12, 25), -- Doom Eternal -> Shooter (genre_id = 25)
(13, 29), -- Resident Evil Village -> Survival Horror (genre_id = 29)
(14, 26), -- Sekiro: Shadows Die Twice -> Action RPG (genre_id = 26)
(15, 22), -- Ghost of Tsushima -> Action (genre_id = 22)
(16, 30), -- Minecraft -> Sandbox (genre_id = 30)
(17, 27), -- Grand Theft Auto V -> Action-Adventure (genre_id = 27)
(18, 27), -- The Last of Us Part II -> Action-Adventure (genre_id = 27)
(19, 31), -- Metal Gear Solid V: The Phantom Pain -> Stealth (genre_id = 31)
(20, 25), -- Overwatch 2 -> Shooter (genre_id = 25)
(21, 32), -- Fortnite -> Battle Royale (genre_id = 32)
(22, 33), -- League of Legends -> MOBA (genre_id = 33)
(23, 25), -- Counter-Strike: Global Offensive -> Shooter (genre_id = 25)
(24, 33), -- Dota 2 -> MOBA (genre_id = 33)
(25, 25), -- Valorant -> Shooter (genre_id = 25)
(26, 25), -- Halo Infinite -> Shooter (genre_id = 25)
(27, 23), -- Starfield -> RPG (genre_id = 23)
(28, 23), -- Baldur's Gate 3 -> RPG (genre_id = 23)
(29, 29), -- Dead Space Remake -> Survival Horror (genre_id = 29)
(30, 26); -- Diablo IV -> Action RPG (genre_id = 26)