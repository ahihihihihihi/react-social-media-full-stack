import express from "express";
import usersRouter from "./routes/users.js"
import authRouter from "./routes/auth.js"
import postsRouter from "./routes/posts.js"
import commentsRouter from "./routes/comments.js"
import likesRouter from "./routes/likes.js"
import cors from "cors";
import cookieParser from "cookie-parser";

const app = express()

app.use(express.json());

app.use(
    cors({
        origin: "http://localhost:3000",
    })
);
app.use(cookieParser());

app.use("/api/auth", authRouter)
app.use("/api/comments", commentsRouter)
app.use("/api/posts", postsRouter)
app.use("/api/likes", likesRouter)
app.use("/api/users", usersRouter)

app.listen(8800, () => {
    console.log("API working!")
})