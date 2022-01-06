// @dart=2.9
/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the TagPost type in your schema. */
@immutable
class TagPost extends Model {
  static const classType = const _TagPostModelType();
  final String id;
  final Tag tag;
  final Post post;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const TagPost._internal(
      {@required this.id, @required this.tag, @required this.post});

  factory TagPost({String id, @required Tag tag, @required Post post}) {
    return TagPost._internal(
        id: id == null ? UUID.getUUID() : id, tag: tag, post: post);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TagPost &&
        id == other.id &&
        tag == other.tag &&
        post == other.post;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("TagPost {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("tag=" + (tag != null ? tag.toString() : "null") + ", ");
    buffer.write("post=" + (post != null ? post.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  TagPost copyWith({String id, Tag tag, Post post}) {
    return TagPost(
        id: id ?? this.id, tag: tag ?? this.tag, post: post ?? this.post);
  }

  TagPost.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        tag = json['tag'] != null
            ? Tag.fromJson(new Map<String, dynamic>.from(json['tag']))
            : null,
        post = json['post'] != null
            ? Post.fromJson(new Map<String, dynamic>.from(json['post']))
            : null;

  Map<String, dynamic> toJson() =>
      {'id': id, 'tag': tag?.toJson(), 'post': post?.toJson()};

  static final QueryField ID = QueryField(fieldName: "tagPost.id");
  static final QueryField TAG = QueryField(
      fieldName: "tag",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Tag).toString()));
  static final QueryField POST = QueryField(
      fieldName: "post",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Post).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "TagPost";
    modelSchemaDefinition.pluralName = "TagPosts";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ]),
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: TagPost.TAG,
        isRequired: true,
        targetName: "tagID",
        ofModelName: (Tag).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: TagPost.POST,
        isRequired: true,
        targetName: "postID",
        ofModelName: (Post).toString()));
  });
}

class _TagPostModelType extends ModelType<TagPost> {
  const _TagPostModelType();

  @override
  TagPost fromJson(Map<String, dynamic> jsonData) {
    return TagPost.fromJson(jsonData);
  }
}
