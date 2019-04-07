# N2CaseStudy
Contains case study answers for N26 org

************* Disclaimer ******
I have developed the solution in developer org so it is having only Admin profile in picture. We can leverage other profiles and give permissions there as well.
Pre-deployment steps for Case study 1 : Please activate Transalation workbench and add English and German as Languages
Please schedule batch by calling "scheduleBatchClass.scheduleMe(); " from developer console; this is only 1 time step. Doing this will make it run automatically at 9:00 AM everyday ; a perfect time to send surveys ;

*********************Case study 2 assumptions : *********************
There can be only 1 product for a contact and each product we will have country populated.

On contact itself while selecting product, the country of product and contact should match.

We are only showing data on case layout and need not to allow any edits.

******************* Other approach/suggestions for Case study 2 : ********************** 

We could have created another object country and then created a junction between country object and product object

We can also enable inline editing for product data on case layout itself to facilitate the easy updations during interaction itself.
