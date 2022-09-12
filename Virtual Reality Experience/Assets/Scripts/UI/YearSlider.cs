using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class YearSlider : MonoBehaviour
{

    public CSVReader reader;
    public GameObject yearText;
    public Slider slid;

    // Start is called before the first frame update
    void Start()
    {
        //slid.onValueChanged.AddListener((year) =>
        //{
        //    yearText.GetComponent<TMPro.TextMeshProUGUI>().text = "Year: " + year;
        //    float yearArrayValue = (year - 1962) / 5;
        //    int yearArrayValueHelp = (int)yearArrayValue;
        //    reader.ApplyColorCountry(yearArrayValueHelp);
        //});
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void YearChange()
    {
        int year = (int)slid.value;
        yearText.GetComponent<TMPro.TextMeshProUGUI>().text = "Year: " + year;
        int yearArrayValue = (year - 1962) / 5;
        reader.ApplyColorCountry(yearArrayValue);
    }
}
