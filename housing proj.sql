select *
from [portfolio project]..[housing data]
where PropertyAddress is null

select *
from [portfolio project]..[housing data]

select dateconverted ,convert( date,SaleDate)
from [portfolio project]..[housing data]

update [portfolio project]..[housing data]
set SaleDate=convert( date,SaleDate)

alter table [portfolio project]..[housing data]
add dateconverted date
update [portfolio project]..[housing data]
set dateconverted=convert( date,SaleDate)





select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
from [portfolio project]..[housing data] a
join
[portfolio project]..[housing data] b
on
a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress=isnull(a.PropertyAddress,b.PropertyAddress)
from [portfolio project]..[housing data] a
join
[portfolio project]..[housing data] b
on
a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

select *
from [portfolio project]..[housing data]



select 
SUBSTRING (PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as adress,
substring (PropertyAddress,CHARINDEX(',',PropertyAddress) +1, len(PropertyAddress)) as adress
from  [portfolio project]..[housing data]


alter table   [portfolio project]..[housing data]

add propertysplitadress nvarchar(255)
update [portfolio project]..[housing data]
set propertysplitadress=SUBSTRING (PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

alter table  [portfolio project]..[housing data]
add propertysplitcity nvarchar(255)

update  [portfolio project]..[housing data]
set propertysplitcity=substring (PropertyAddress,CHARINDEX(',',PropertyAddress) +1, len(PropertyAddress))


select *
from[portfolio project]..[housing data]



Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From [portfolio project]..[housing data]

alter table [portfolio project]..[housing data]
add ownersplitaddress nvarchar(255)
update [portfolio project]..[housing data]
set OwnerAddress= PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

alter table [portfolio project]..[housing data]
add ownersplitcity nvarchar(255)
update [portfolio project]..[housing data]
set OwnerAddress=PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

alter table [portfolio project]..[housing data]
add ownersplitstate nvarchar(255)
update [portfolio project]..[housing data]
set OwnerAddress=PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

select *
from[portfolio project]..[housing data]

select SoldAsVacant,
case when SoldAsVacant= 'Y' then 'Yes'
     when SoldAsVacant='N' then 'No'
	 else SoldAsVacant
	 end
from[portfolio project]..[housing data]
update [portfolio project]..[housing data]
set SoldAsVacant= case when SoldAsVacant= 'Y' then 'Yes'
     when SoldAsVacant='N' then 'No'
	 else SoldAsVacant
	 end
	 from[portfolio project]..[housing data]

	 select SoldAsVacant,COUNT(SoldAsVacant)
	 from[portfolio project]..[housing data]
	 group by SoldAsVacant



	 with rownumCTE as (
select *,
Row_number() over(
                  partition by ParcelID,
				   PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
		 from[portfolio project]..[housing data])	
		select *
		 from rownumCTE
		 where row_num >1
		order by propertyaddress


















