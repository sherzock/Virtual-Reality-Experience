using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class SphereGenerator
{
    public static Mesh GenerateSphereMesh(MeshRenderer meshRenderer, MeshFilter filter, int resolution, int size, Vector3 directions)
    {
        meshRenderer.sharedMaterial = new Material(Shader.Find("Standard"));

        Mesh planeMesh = UpdateSphereMesh(filter, resolution, size, directions);

        return planeMesh;
    }
    public static Mesh UpdateSphereMesh(MeshFilter filter, int resolution, int size, Vector3 directions)
    {
        Mesh planeMesh = new Mesh();

        int vertexPerRow = VertexAndTriangles.GetVertexPerRow(resolution);
        int numberOfVertices = vertexPerRow * vertexPerRow;
        Vector3[] vertices = VertexAndTriangles.GetSphereVertices(vertexPerRow, numberOfVertices, size, directions);

        int[] triangles = VertexAndTriangles.GetTriangles(vertexPerRow, resolution);

        planeMesh.vertices = vertices;
        planeMesh.triangles = triangles;

        planeMesh.RecalculateNormals();

        filter.mesh = planeMesh;

        return planeMesh;

    }

}
