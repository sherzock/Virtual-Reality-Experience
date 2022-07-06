using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class VertexAndTriangles
{
    public static int[] GetTriangles(int vertexPerRow, int resolution)
    {
        int vertexCount = vertexPerRow * vertexPerRow;

        int spaceNeededToStoreATriangle = 6;
        int trianglesNumber = (2 * ((int)Mathf.Pow(2, 2 * resolution))) * 3;
        int[] triangles = new int[trianglesNumber * spaceNeededToStoreATriangle];

        int triangleCounter = 0;

        for (int i = 0; triangleCounter < (vertexCount - vertexPerRow); i += 6)
        {
            // Skip edge vertices
            if (i != 0 && ((i / 6) + 1) % vertexPerRow == 0)
            {
                triangleCounter++;
                continue;
            }

            triangles[i] = triangleCounter;
            triangles[i + 1] = triangleCounter + vertexPerRow + 1;
            triangles[i + 2] = triangleCounter + vertexPerRow;

            triangles[i + 3] = triangleCounter;
            triangles[i + 4] = triangleCounter + 1;
            triangles[i + 5] = triangleCounter + vertexPerRow + 1;

            triangleCounter++;
        }

        return triangles;
    }


    public static Vector3[] GetSphereVertices(int vertexPerRow, int numberOfVertices, int size, Vector3 upDirection)
    {
        Vector3[] vertices = new Vector3[numberOfVertices];

        Vector3 localUp = upDirection;
        Vector3 Dx = new Vector3(localUp.y, localUp.z, localUp.x);
        Vector3 Dy = Vector3.Cross(localUp, Dx);

        for (int i = 0; i < vertexPerRow; i++)
        {
            for (int j = 0; j < vertexPerRow; j++)
            {
                float yVertexPercent = (float)i / (vertexPerRow - 1);
                float xVertexPercent = (float)j / (vertexPerRow - 1);
                vertices[j + i * vertexPerRow] = localUp + (xVertexPercent - .5f) * 2 * Dx + (yVertexPercent - .5f) * 2 * Dy;
                vertices[j + i * vertexPerRow] = vertices[j + i * vertexPerRow].normalized * size;
            }
        }

        return vertices;
    }

    public static int GetVertexPerRow(int resolution)
    {
        int vertexCount = 2;

        for (int i = 0; i < resolution; i++)
        {
            vertexCount += (int)Mathf.Pow(2, i);
        }

        return vertexCount;
    }
}
