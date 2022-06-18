-- Cleaning Data in SQL Queries

Select *
from PortfolioProject..NashvilleHousing

--Standardize Date Format

Select SaleDateConverted, Convert(Date,SaleDate)
from PortfolioProject..NashvilleHousing

Update NashvilleHousing
SET SaleDate = Convert(Date,SaleDate)

Alter Table NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = Convert(Date,SaleDate)



--Populate Property Address data

Select *
from PortfolioProject..NashvilleHousing
--where PropertyAddress is null
order by ParcelID


select a.[UniqueID ], a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject..NashvilleHousing a
Join PortfolioProject..NashvilleHousing b
on a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is Null

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject..NashvilleHousing a
Join PortfolioProject..NashvilleHousing b
on a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is Null


-- Breaking out Address into Individual Columns (Address, City, State)

Select PropertyAddress
from PortfolioProject..NashvilleHousing
--where PropertyAddress is null
order by ParcelID


Select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) as Address
From PortfolioProject..NashvilleHousing
 

Alter Table PortfolioProject..NashvilleHousing
Add PropertySplitAddress nvarchar(255);

Update PortfolioProject..NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1)

Alter Table PortfolioProject..NashvilleHousing
Add PropertySplitCity nvarchar(255);

Update PortfolioProject..NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress))


Select *
From PortfolioProject..NashvilleHousing

Select OwnerAddress
From PortfolioProject..NashvilleHousing

Select 
PARSENAME(Replace(OwnerAddress,',','.'),3),
PARSENAME(Replace(OwnerAddress,',','.'),2),
PARSENAME(Replace(OwnerAddress,',','.'),1)
From PortfolioProject..NashvilleHousing


Alter Table PortfolioProject..NashvilleHousing
Add OwnerSplitAddress nvarchar(255);

Update PortfolioProject..NashvilleHousing
SET OwnerSplitAddress = PARSENAME(Replace(OwnerAddress,',','.'),3)

Alter Table PortfolioProject..NashvilleHousing
Add OwnerSplitCity nvarchar(255);

Update PortfolioProject..NashvilleHousing
SET OwnerSplitCity = PARSENAME(Replace(OwnerAddress,',','.'), 2)

Alter Table PortfolioProject..NashvilleHousing
Add OwnerSplitState nvarchar(255);

Update PortfolioProject..NashvilleHousing
SET OwnerSplitState = PARSENAME(Replace(OwnerAddress,',','.'),1)


Select *
From PortfolioProject..NashvilleHousing

--Change Y and N to Yes and No in "SoldAsVacant" Field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject..NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
, case when SoldAsVacant ='Y' THen 'Yes'
when SoldAsVacant = 'N' Then 'No'
else SoldAsVacant
End	
From PortfolioProject..NashvilleHousing

Update PortfolioProject..NashvilleHousing
SET SoldAsVacant = case when SoldAsVacant ='Y' THen 'Yes'
when SoldAsVacant = 'N' Then 'No'
else SoldAsVacant
End	
From PortfolioProject..NashvilleHousing

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject..NashvilleHousing
Group by SoldAsVacant
Order by 2

-- Remove Dulpicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() over (
	Partition by parcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY UniqueID
				 ) row_num

	 
From PortfolioProject..NashvilleHousing
--Order by ParcelID
)
DELETE
From RowNumCTE
Where row_num > 1
--ORDER by PropertyAddress

Select *
from PortfolioProject..NashvilleHousing



--Delete Unused Column

Select *
from PortfolioProject..NashvilleHousing

ALTER TABLE PortfolioProject..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE PortfolioProject..NashvilleHousing
DROP COLUMN SaleDate

