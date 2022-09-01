using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EarthRotationandMovement : MonoBehaviour
{

    public bool IsGrabbed = false;
    public bool CanBeGrabbed = false;
    public bool IsRotating = true;
    public float RotationSpeed = 0.1f;

    Vector3 mPrevPos = Vector3.zero;
    Vector3 mPosDelta = Vector3.zero;


    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        
        if (IsRotating && !IsGrabbed)
            AutoRotate();
        
        if(CanBeGrabbed)
            GrabRotate();
    }

    private void OnMouseOver()
    {
        CanBeGrabbed = true;
    }

    private void OnMouseExit()
    {
        CanBeGrabbed = false;
    }

    private void AutoRotate()
    {
        this.transform.Rotate(0, RotationSpeed, 0);
    }

    private void GrabRotate()
    {
        if (Input.GetMouseButton(0))
        {
            IsGrabbed = true;
            mPosDelta = Input.mousePosition - mPrevPos;
            if(Vector3.Dot(transform.up, Vector3.up) >= 0)
            {
                transform.Rotate(transform.up, -Vector3.Dot(mPosDelta, Camera.main.transform.right), Space.World);
            }
            else
            {
                transform.Rotate(transform.up, Vector3.Dot(mPosDelta, Camera.main.transform.right), Space.World);
            }

            transform.Rotate(Camera.main.transform.right, Vector3.Dot(mPosDelta, Camera.main.transform.up), Space.World);
        }
        else
        {
            IsGrabbed = false;
        }
        mPrevPos = Input.mousePosition;
    }
}
