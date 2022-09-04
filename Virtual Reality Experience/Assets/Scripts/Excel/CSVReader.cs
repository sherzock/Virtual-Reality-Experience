using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CSVReader : MonoBehaviour
{
    
    public TextAsset CsvFile;

    public GameObject Africa;
    public GameObject Asia;
    public GameObject Antartica;
    public GameObject America;
    public GameObject Europe;
    public GameObject Oceania;


    [System.Serializable]
    public class Countries
    {
        public Country[] country;
    }

    public Countries countries = new Countries();

    // Start is called before the first frame update
    void Start()
    {
        //ReadCsv();
        CreateCountries();
    }
    
    void CreateCountries()
    {

        int AfricaCountries = Africa.transform.childCount;
        int AmericaCountries = America.transform.childCount;
        int AsiaCountries = Asia.transform.childCount;
        int OceaniaCountries = Oceania.transform.childCount;
        int EuropeCountries = Europe.transform.childCount;
        int AntarticaCountries = Antartica.transform.childCount;

        int countriesNumber = AfricaCountries + AmericaCountries + AsiaCountries + OceaniaCountries + EuropeCountries + AntarticaCountries;

        int CountriesSize = countriesNumber /*/ 4 - 1*/;
        countries.country = new Country[CountriesSize];

        for (int i = 0; i < Africa.transform.childCount; i++)
        {

            countries.country[i] = new Country();
            countries.country[i].name =  Africa.transform.GetChild(i).name;
            countries.country[i].meshMat =  Africa.transform.GetChild(i).gameObject;
            
        }
        
        for (int i = 0; i < America.transform.childCount; i++)
        {

            countries.country[i + AfricaCountries] = new Country();
            countries.country[i + AfricaCountries].name = America.transform.GetChild(i).name;
            countries.country[i + AfricaCountries].meshMat = America.transform.GetChild(i).gameObject;

        }

        for (int i = 0; i < Asia.transform.childCount; i++)
        {

            countries.country[i + AfricaCountries + AmericaCountries] = new Country();
            countries.country[i + AfricaCountries + AmericaCountries].name = Asia.transform.GetChild(i).name;
            countries.country[i + AfricaCountries + AmericaCountries].meshMat = Asia.transform.GetChild(i).gameObject;

        }

        for (int i = 0; i < Europe.transform.childCount; i++)
        {

            countries.country[i + AfricaCountries + AmericaCountries + AsiaCountries] = new Country();
            countries.country[i + AfricaCountries + AmericaCountries + AsiaCountries].name = Europe.transform.GetChild(i).name;
            countries.country[i + AfricaCountries + AmericaCountries + AsiaCountries].meshMat = Europe.transform.GetChild(i).gameObject;

        }

        for (int i = 0; i < Oceania.transform.childCount; i++)
        {

            countries.country[i + AfricaCountries + AmericaCountries + AsiaCountries + EuropeCountries] = new Country();
            countries.country[i + AfricaCountries + AmericaCountries + AsiaCountries + EuropeCountries].name = Oceania.transform.GetChild(i).name;
            countries.country[i + AfricaCountries + AmericaCountries + AsiaCountries + EuropeCountries].meshMat = Oceania.transform.GetChild(i).gameObject;

        }

        for (int i = 0; i < Antartica.transform.childCount; i++)
        {

            countries.country[i + AfricaCountries + AmericaCountries + AsiaCountries + EuropeCountries + OceaniaCountries] = new Country();
            countries.country[i + AfricaCountries + AmericaCountries + AsiaCountries + EuropeCountries + OceaniaCountries].name = Antartica.transform.GetChild(i).name;
            countries.country[i + AfricaCountries + AmericaCountries + AsiaCountries + EuropeCountries + OceaniaCountries].meshMat = Antartica.transform.GetChild(i).gameObject;

        }

        string[] data = CsvFile.text.Split(new string[] { ";", "\n" }, System.StringSplitOptions.None);
        int tableSize = data.Length / 13 - 1;

        for (int i = 0; i < tableSize; i++)
        {
            for (int j = 0; j < CountriesSize; j++)
            {
                if(countries.country[j].name == data[13 * (i + 1)])
                {
                    countries.country[j].pop1962 = int.Parse(data[13 * (i + 1) + 1]);
                    countries.country[j].pop1972 = int.Parse(data[13 * (i + 1) + 3]);
                    countries.country[j].pop1967 = int.Parse(data[13 * (i + 1) + 2]);
                    countries.country[j].pop1977 = int.Parse(data[13 * (i + 1) + 4]);
                    countries.country[j].pop1982 = int.Parse(data[13 * (i + 1) + 5]);
                    countries.country[j].pop1987 = int.Parse(data[13 * (i + 1) + 6]);
                    countries.country[j].pop1992 = int.Parse(data[13 * (i + 1) + 7]);
                    countries.country[j].pop1997 = int.Parse(data[13 * (i + 1) + 8]);
                    countries.country[j].pop2002 = int.Parse(data[13 * (i + 1) + 9]);
                    countries.country[j].pop2007 = int.Parse(data[13 * (i + 1) + 10]);
                    countries.country[j].pop2012 = int.Parse(data[13 * (i + 1) + 11]);
                    countries.country[j].pop2017 = int.Parse(data[13 * (i + 1) + 12]);
                }
            }
        }

    }

    //void ReadCsv()
    //{
    //    string[] data = CsvFile.text.Split(new string[] { ";", "\n" }, System.StringSplitOptions.None);

    //    int tableSize = data.Length / 13 - 1;

    //    for (int i = 0; i < tableSize; i++)
    //    {
    //        countries.country[i] = new Country();
    //        countries.country[i].name = data[4 * (i + 1)];
    //        countries.country[i].id = int.Parse(data[4 * (i + 1) + 1]);
    //        countries.country[i].data1 = float.Parse(data[4 * (i + 1) + 2]);
    //        countries.country[i].data2 = float.Parse(data[4 * (i + 1) + 3]);

    //    }
    //}
}
