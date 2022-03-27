USE MySaleBusiness


CREATE TABLE Category
(
	CategoryId INT IDENTITY,
	CategoryName VARCHAR(15) NOT NULL,
	[Description] VARCHAR(100) NOT NULL,
	CONSTRAINT PK_CATEGORY PRIMARY KEY (CategoryId)
)

CREATE UNIQUE INDEX CategoryName ON Category (
	CategoryName
)
GO

CREATE UNIQUE INDEX PrimaryKey on Category (
	CategoryId
)
GO

CREATE TABLE Member
(
	MemberId INT IDENTITY,
	Email VARCHAR(100) NOT NULL,
	CompanyName VARCHAR(40) NOT NULL,
	City VARCHAR(15) NOT NULL,
	Country VARCHAR(15) NOT NULL,
	[Password] VARCHAR(30) NOT NULL,
	CONSTRAINT PK_MEMBER PRIMARY KEY (MemberId)
)

CREATE UNIQUE INDEX PrimaryKey on [Member] (
	MemberId
)
GO

CREATE UNIQUE INDEX MemberEmailIdx on [Member] (
	Email
)
go

CREATE TABLE [Order]
(
	OrderId INT IDENTITY,
	MemberId INT NOT NULL,
	OrderDate DATETIME NOT NULL,
	RequiredDate DATETIME NULL,
	ShippedDate DATETIME NULL,
	Freight MONEY NULL
		CONSTRAINT PK_ORDERS PRIMARY KEY (OrderId)
)

CREATE UNIQUE INDEX PrimaryKey ON [Order] (
	OrderId
)
GO

CREATE INDEX OrderMemberIdx on [Order] (
	MemberId
)
GO

CREATE TABLE Product
(
	ProductId INT IDENTITY,
	CategoryId INT NOT NULL,
	ProductName VARCHAR(40) NOT NULL,
	[Weight] VARCHAR(20) NOT NULL,
	UnitPrice MONEY NOT NULL,
	UnitInStock INT NOT NULL,
	CONSTRAINT PK_PRODUCT PRIMARY KEY (ProductId)
)

CREATE UNIQUE INDEX PrimaryKey on Product (
	ProductId
)
GO

CREATE INDEX CategoriesProducts on Product (
	CategoryId
)
GO

CREATE INDEX CategoryID on Product (
	CategoryId
)
GO

CREATE INDEX ProductName on Product (
	ProductName
)
GO


CREATE TABLE OrderDetail
(
	OrderId INT NOT NULL,
	ProductId INT NOT NULL,
	UnitPrice MONEY NOT NULL,
	Quantity INT NOT NULL,
	Discount FLOAT NOT NULL,
	CONSTRAINT PK_ORDERDETAIL PRIMARY KEY (OrderId, ProductId)
)

CREATE UNIQUE INDEX PrimaryKey ON OrderDetail (
	OrderId,
	ProductId
)
GO

CREATE INDEX OrderID on OrderDetail (
	OrderId
)
GO

CREATE INDEX [ProductsOrder Details] on OrderDetail (
	ProductId
)
GO

ALTER TABLE [Order]
	ADD CONSTRAINT FK_ORDER_REFERENCE_MEMBER FOREIGN KEY (MemberId)
	REFERENCES Member (MemberId)
GO

ALTER TABLE OrderDetail
	ADD CONSTRAINT FK_ORDERDET_REFERENCE_ORDER FOREIGN KEY (OrderId)
	REFERENCES [Order] (OrderId)
GO

ALTER TABLE OrderDetail
	ADD CONSTRAINT FK_ORDERDET_REFERENCE_PRODUCT FOREIGN KEY (ProductId)
	REFERENCES Product (ProductId)
GO

ALTER TABLE Product
	ADD CONSTRAINT FK_PRODUCT_REFERENCE_CATEGORY FOREIGN KEY (CategoryId)
	REFERENCES Category (CategoryId)
GO