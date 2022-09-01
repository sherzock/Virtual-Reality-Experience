using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EarthRotationandMovement : MonoBehaviour
{

    public bool IsGrabbed = false;
    public bool IsRotating = true;
    public float RotationSpeed = 0.1f;

    Vector3 mPrevPos = Vector3.zero;
    Vector3 mPosDelta = Vector3.zero;


    // Start is called before the first frame update
    void Start()
    {
        //IsGrabbed = false;
        //IsRotating = true;
    }

    // Update is called once per frame
    void Update()
    {
        //if (IsRotating)
        //    AutoRotate();

        GrabRotate();
    }


    private void AutoRotate()
    {
        this.transform.Rotate(0, RotationSpeed, 0);
    }

    private void GrabRotate()
    {
        if (Input.GetMouseButton(0))
        {
            mPosDelta = Input.mousePosition - mPrevPos;
            transform.Rotate(transform.up, -Vector3.Dot(mPosDelta, Camera.main.transform.right), Space.World);
            transform.Rotate(Camera.main.transform.right, Vector3.Dot(mPosDelta, Camera.main.transform.up), Space.World);
        }
        mPrevPos = Input.mousePosition;
    }
}
