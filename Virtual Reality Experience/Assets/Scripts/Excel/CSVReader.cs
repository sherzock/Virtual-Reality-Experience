using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CSVReader : MonoBehaviour
{
    
    public TextAsset CsvFile;


    [System.Serializable]
    public class Countries
    {
        public Country[] country;
    }

    public Countries countries = new Countries();

    // Start is called before the first frame update
    void Start()
    {
        ReadCsv();
    }

    void ReadCsv()
    {
        string[] data = CsvFile.text.Split(new string[] { ";", "\n" }, System.StringSplitOptions.None);

        int tableSize = data.Length / 4 - 1;
        countries.country = new Country[tableSize];

        for (int i = 0; i < tableSize; i++)
        {
            countries.country[i] = new Country();
            countries.country[i].name = data[4 * (i + 1)];
            countries.country[i].id = int.Parse(data[4 * (i + 1) + 1]);
            countries.country[i].data1 = float.Parse(data[4 * (i + 1) + 2]);
            countries.country[i].data2 = float.Parse(data[4 * (i + 1) + 3]);

        }
    }
}
