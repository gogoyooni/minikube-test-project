const express = require("express");
const cors = require("cors");
const { PrismaClient } = require('@prisma/client');
const dotenv = require("dotenv");

dotenv.config();
const prisma = new PrismaClient();

const app = express();

app.use(cors());

app.use(express.json());

app.get("/api/v1/test", (req, res) => {
  try {
    const users = [
      { id: 1, name: "John Doe" },
      { id: 2, name: "Jane Doe" },
    ];

    return res.status(200).json({ users });
  } catch (error) {
    throw error;
  }
});

//test api
// app.get("/api/v1/test", (req, res) => {
//   try {
//     res.status(200).json({ message: "API is working" });
//   } catch (error) {
//     res.status(500).json({ message: error.message });
//   }
// });

//get all users
app.get("/api/v1/users", async (req, res) => {
  try {
    const users = await prisma.user.findMany();
    res.status(200).json(users);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

//get user by id
app.get("/api/v1/users/:id", async (req, res) => {
  try {
    const user = await prisma.user.findUnique({
      where: {
        id: Number(req.params.id),
      },
    });
    res.status(200).json(user);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

//create user
app.post("/api/v1/users", async (req, res) => {
  try {
    const user = await prisma.user.create({
      data: {
        name: req.body.name,
        email: req.body.email,
      },
    });
    res.status(201).json(user);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

//update user
app.put("/api/v1/users/:id", async (req, res) => {
  try {
    const user = await prisma.user.update({
      where: {
        id: Number(req.params.id),
      },
      data: {
        name: req.body.name,
        email: req.body.email,
      },
    });
    res.status(200).json(user);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

//delete user
app.delete("/api/v1/users/:id", async (req, res) => {
  try {
    const user = await prisma.user.delete({
      where: {
        id: Number(req.params.id),
      },
    });
    res.status(200).json(user);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

app.listen(6666, () => console.log("App listening on port 6666!"));
