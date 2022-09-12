using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SettingsButton : MonoBehaviour
{
    public GameObject Menu1;
    public GameObject Menu2;
    public GameObject Menu1New;
    public GameObject Menu2New;

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
        Menu2.SetActive(false);
        Menu1New.SetActive(true);
        Menu2New.SetActive(true);
    }
}
