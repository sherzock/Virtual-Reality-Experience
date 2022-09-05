using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class Country
{
    public string name;

    // 1962/1967/1972/1977/1982/1987/1992/1997/2002/2007/2012/2017
    public int[] NetMigration = new int[11];
    public float[] NetMigrationColor = new float[11];



    public GameObject capital;
    public GameObject meshMat;
}
