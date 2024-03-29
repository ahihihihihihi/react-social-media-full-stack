import "./Post.scss";
import FavoriteBorderOutlinedIcon from "@mui/icons-material/FavoriteBorderOutlined";
import FavoriteOutlinedIcon from "@mui/icons-material/FavoriteOutlined";
import TextsmsOutlinedIcon from "@mui/icons-material/TextsmsOutlined";
import ShareOutlinedIcon from "@mui/icons-material/ShareOutlined";
import MoreHorizIcon from "@mui/icons-material/MoreHoriz";
import { Link } from "react-router-dom";
import { useState } from "react";
import Comments from "../comments/Comments";
import moment from "moment";
import { useQuery, useQueryClient, useMutation } from "@tanstack/react-query";
import { makeRequest } from "../../axios";
import { useContext } from "react";
import { AuthContext } from "../../context/authContext";

const Post = ({ post }) => {

    const [commentOpen, setCommentOpen] = useState(false);

    const [menuOpen, setMenuOpen] = useState(false);

    const [commentNumber, setCommentNumber] = useState(0);

    const [once, setOnce] = useState(1);

    const { currentUser } = useContext(AuthContext);

    const queryClient = useQueryClient();

    const { isLoading, error, data } = useQuery(["likes", post.id], () =>
        makeRequest.get("/likes?postId=" + post.id).then((res) => {
            return res.data;
        })
    );

    if (once) {
        makeRequest.get("/comments?postId=" + post.id).then((res) => {
            // console.log(">>>check temp_comments:", res.data)
            setOnce(0)
            setCommentNumber(res.data.length)
        })
    }

    const mutation = useMutation(
        (liked) => {
            if (liked) return makeRequest.delete("/likes?postId=" + post.id);
            return makeRequest.post("/likes", { postId: post.id });
        },
        {
            onSuccess: () => {
                // Invalidate and refetch
                queryClient.invalidateQueries(["likes"]);
            },
        }
    );

    const handleLike = () => {
        mutation.mutate(data.includes(currentUser.id));
    };

    const handleDelete = () => {
        deleteMutation.mutate(post.id);
    };

    const deleteMutation = useMutation(
        (postId) => {
            return makeRequest.delete("/posts/" + postId);
        },
        {
            onSuccess: () => {
                // Invalidate and refetch
                queryClient.invalidateQueries(["posts"]);
            },
        }
    );

    return (
        <div className="post">
            <div className="container">
                <div className="user">
                    <div className="userInfo">
                        <Link
                            to={`/profile/${post.userId}`}
                            className="link"
                        >
                            <img src={"/upload/" + post.profilePic} alt="" />
                        </Link>
                        <div className="details">
                            <Link
                                to={`/profile/${post.userId}`}
                                className="link"
                            >
                                <span className="name">{post.name}</span>
                            </Link>
                            <span className="date">{moment(post.createdAt).fromNow()}</span>
                        </div>
                    </div>
                    <MoreHorizIcon style={post.userId === currentUser.id ? { cursor: "pointer" } : { cursor: "not-allowed" }} onClick={() => setMenuOpen(!menuOpen)} />
                    {menuOpen && post.userId === currentUser.id && (
                        <button onClick={handleDelete}>delete</button>
                    )}
                </div>
                <div className="content">
                    <p>{post.desc}</p>
                    <img src={"/upload/" + post.img} alt="" />
                </div>
                <div className="info">
                    <div className="item">
                        {isLoading ?
                            ("loading") :
                            data?.includes(currentUser.id) ?
                                <FavoriteOutlinedIcon
                                    style={{ color: "red" }}
                                    onClick={handleLike}
                                />
                                :
                                <FavoriteBorderOutlinedIcon
                                    onClick={handleLike}
                                />}
                        {data?.length === 0 ? " Like" : data?.length === 1 ? " 1 Like" : ` ${data?.length} Likes`}
                    </div>
                    <div className="item" onClick={() => setCommentOpen(!commentOpen)}>
                        <TextsmsOutlinedIcon />
                        {commentNumber === 0 ? " Comment" : commentNumber === 1 ? " 1 Comment" : ` ${commentNumber} Comments`}
                    </div>
                    <div className="item">
                        <ShareOutlinedIcon />
                        Share
                    </div>
                </div>
                {commentOpen && <Comments
                    postId={post.id}
                    setCommentNumber={setCommentNumber}
                />}
            </div>
        </div>
    );
};

export default Post;