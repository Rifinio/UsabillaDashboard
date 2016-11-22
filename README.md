# UsabillaDashboard
My implementation of the Usabilla ios challenge
![alt tag](https://s16.postimg.org/ppm92xjol/Dashbilla_logo.png)
#DashBilla
Dashbilla is my implementation of the Usabilla iOS Challenge. The idea here is to represent the data retrieved from the json file, and show them in beautiful Charts with meaninful and clear statistics.

## Process
So, reading the json file that contains user feedbacks, i went on to identify and only parse the needed parameters :

- Browser & version
- Platform
- Geo location
- Rating
- Labels

Once the parameters made sense, i had the idea of showing the data in a dashboard, using charts. And one very nice feature that i thought of is to implement a usabilla feedback form, and since the api is only for clients i created one myself.

## Screenshots
### Mainview : Dashboard
A collectionView that shows the different KPI in different chart types : PieChart, Horizontal Bar Chart and Vertical bar chart.

![alt tag](https://s13.postimg.org/9qq2fypdz/Simulator_Screen_Shot_22_nov_2016_a_01_26_05.png)

![alt tag](https://s22.postimg.org/y1km84kfl/Simulator_Screen_Shot_22_nov_2016_a_01_26_18.png)

## ABUsabillaAPI
So, ABUsabillaAPI allows you to implement it in any ViewController and helps you highlight the UI elements that you as a developer want the user to be able to highlight and give feedback about.
// screenshot of feedback here
###how to use ?
// code 



