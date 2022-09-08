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
    public int CountriesSize;
    public int tableSize;

    string lastSelectedCountry = "";


   [System.Serializable]
    public class Countries
    {
        public Country[] country;

        public int [] NetMigrationMax = new int[11];
        public int [] NetMigrationMin = new int[11];
        public int [] NetMigrationLimits = new int[11];
    }

    public Countries countries = new Countries();

    // Start is called before the first frame update
    void Start()
    {
        //ReadCsv();
        CreateCountries();
        CreateColorToCountry();
        ApplyColorCountry();
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

        CountriesSize = countriesNumber /*/ 4 - 1*/;
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
        tableSize = data.Length / 13 - 1;

        for (int i = 0; i < tableSize; i++)
        {
            for (int j = 0; j < CountriesSize; j++)
            {
                if(countries.country[j].name == data[13 * (i + 1)])
                {

                    for(int k = 0; k < 11; k++)
                    {
                        countries.country[j].NetMigration[k] = int.Parse(data[13 * (i + 1) + k + 1]);
                        if (countries.NetMigrationMin[k] > int.Parse(data[13 * (i + 1) + k + 1]))
                            countries.NetMigrationMin[k] = int.Parse(data[13 * (i + 1) + k + 1]);
                        if (countries.NetMigrationMax[k] < int.Parse(data[13 * (i + 1) + k + 1]))
                            countries.NetMigrationMax[k] = int.Parse(data[13 * (i + 1) + k + 1]);
                    }
                }
            }
        }



    }

    void CreateColorToCountry()
    {

        for (int i = 0; i < CountriesSize; i++)
        {
            for (int j = 0; j < 11; j++)
            {
                countries.country[i].NetMigrationColor[j] = ReScaleValue(countries.NetMigrationMin[j], countries.NetMigrationMax[j], 0f, 1f, countries.country[i].NetMigration[j]);                
            }
        }
    }

    void ApplyColorCountry()
    {
        for(int i = 0; i < CountriesSize; i++)
        {
            countries.country[i].meshMat.GetComponent<MeshRenderer>().material.color = Color.Lerp(Color.red, Color.green, countries.country[i].NetMigrationColor[0]);
        }
    }

    public float ReScaleValue(float OldMin, float OldMax, float NewMin, float NewMax, float OldValue)
    {

        float OldRange = (OldMax - OldMin);
        float NewRange = (NewMax - NewMin);
        float NewValue = (((OldValue - OldMin) * NewRange) / OldRange) + NewMin;

        return (NewValue);
    }

    public void NewSelectedCountry(string NewCountryName)
    {

        for(int i = 0; i < CountriesSize; i++)
        {
            if (countries.country[i].name == lastSelectedCountry)
                DeSelectCountry(countries.country[i]);
        }

        for (int i = 0; i < CountriesSize; i++)
        {
            if (countries.country[i].name == NewCountryName)
                SelectCountry(countries.country[i]);
        }

    }

    void DeSelectCountry(Country country)
    {
        country.meshMat.GetComponent<Outline>().enabled = false;
        country.meshMat.GetComponent<SelectedCountry>().enabled = false;

    }

    void SelectCountry(Country country)
    {
        country.meshMat.GetComponent<Outline>().enabled = true;
        lastSelectedCountry = country.name;
    }
}
