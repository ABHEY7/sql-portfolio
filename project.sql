select * from dataset1;
select * from dataset2;

#-number of rows in datasets
select count(*) from dataset1;
select count(*) from dataset2;

#-----dataset for jharkhand and bihar
select * from dataset1 where state in ('jharkhand' ,'bihar'); 

#----population of india 
select sum(population) as population from dataset2 ;

#----average growth
select avg(growth)*100 as avg_growth from dataset1 ;    # avg of india 
select state,avg(growth)* 100 as avg_growth from dataset1 group by state;  #avg of all states

#---avg sex ratio(dataset1)
select avg(sex_ratio)*100 from dataset1;       # avg of india 
select state,round(avg(sex_ratio),0) from dataset1 group by state ;   #avg of all the states 

#---avg literacy rate
select avg(literacy) from dataset1;    #avg of india
select state,avg(literacy) as literacy from dataset1 group by state;  #avg of all states
select state,avg(literacy) as literacy from dataset1 group by state having literacy>80 order by literacy desc;  # the states which has greater then 80 literacy rate using having 

#top 3 states having the highest growth ratio
select state, round(avg(growth)*100,0) from dataset1 group by state order by avg(growth) desc limit 3;
#bottom 3 states having the lowest growth ratio
select state,round(avg(growth)*100) from dataset1 group by state order by avg(growth) asc limit 3;

#top 3 states having the highest sex ratio
select state,round(avg(sex_ratio)) as avg_sex_ratio from dataset1 group by state order by avg_sex_ratio desc ;
#bottom 3 states having the lowest sex ratio
select state,avg(sex_ratio) as avg_sex_ratio from dataset1 group by state order by avg_sex_ratio asc limit 3 ;

#top and bottom three states in literacy states(using union ) 
(select state,avg(literacy) from dataset1 group by state order  by  avg(Literacy) desc limit 3) union 
(select state,avg(literacy) from dataset1 group by state order  by  avg(Literacy) asc limit 3); 


#states staring with letter 'a'
select distinct STATE from dataset1 where state like "a%";
#states starting with letter 'a' or 'b'
select distinct state from dataset1 where state like 'a%' or state  like "b%";
#states staring with letter 'a' and  ending with 'h'
select distinct STATE from dataset1 where state like "a%m";

#joining both table

#total males and females 
#first i will perform inner join on both table and then using formula i will calculate the male and female 
#on district column and at last i will find  state wise sum of males and female using group  by  function.
select e.state,sum(e.female) as female ,sum(e.male)as male from
(select d.district, d.state,round((d.population*d.Sex_Ratio)/(d.Sex_Ratio+1),0) as female,round(d.population/(d.Sex_Ratio+1),0) as male from 
(select d1.district,d1.state,d2.population, d1.sex_ratio/1000 as sex_ratio  from dataset1 as d1 inner join dataset2 as d2 on d1.District=d2.District)d)e group by e.state;


select e.state,sum(e.prev_population) as prev_pop,e.population from
(select d.District,d.state,d.Growth,round(d.population/(1+d.Growth),0) as prev_population ,d.population from
(select d1.District,d1.state,d1.Growth,d2.population from dataset1 as d1 inner join dataset2 as d2 on d1.District=d2.District)d)e group by e.state;




