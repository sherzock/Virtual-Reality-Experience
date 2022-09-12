using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SettingsMainMenu : MonoBehaviour
{
    public GameObject Menu1;
    public GameObject Menu2New;
    public GameObject Menu1New;


    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {

    }

    public void ChangeMenu()
    {
        Menu1.SetActive(false);
        Menu2New.SetActive(true);
        Menu1New.SetActive(true);

    }
}
