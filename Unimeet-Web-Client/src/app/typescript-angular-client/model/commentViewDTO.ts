/**
 * Unimeet Service
 * User Api Documentation
 *
 * OpenAPI spec version: 1.0.0
 * Contact: emreecann28@gmail.com
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */
import { PostViewDTO } from './postViewDTO';
import { UserViewDTO } from './userViewDTO';


export interface CommentViewDTO { 
    commentId?: number;
    content?: string;
    posts?: PostViewDTO;
    users?: UserViewDTO;
}
