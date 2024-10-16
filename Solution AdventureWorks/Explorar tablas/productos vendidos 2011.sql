select * from Sales.SalesOrderDetail;

select top 10 ProductID, sum(OrderQty) as unidades from Sales.SalesOrderDetail
where year(ModifiedDate) = 2011
group by ProductID
order by unidades desc;

