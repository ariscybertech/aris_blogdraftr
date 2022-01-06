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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Post type in your schema. */
@immutable
class Post extends Model {
  static const classType = const _PostModelType();
  final String id;
  final String title;
  final String blogID;
  final String body;
  final List<TagPost> tags;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Post._internal(
      {@required this.id,
      @required this.title,
      @required this.blogID,
      @required this.body,
      this.tags});

  factory Post(
      {String id,
      @required String title,
      @required String blogID,
      @required String body,
      List<TagPost> tags}) {
    return Post._internal(
        id: id == null ? UUID.getUUID() : id,
        title: title,
        blogID: blogID,
        body: body,
        tags: tags != null ? List.unmodifiable(tags) : tags);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Post &&
        id == other.id &&
        title == other.title &&
        blogID == other.blogID &&
        body == other.body &&
        DeepCollectionEquality().equals(tags, other.tags);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Post {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$title" + ", ");
    buffer.write("blogID=" + "$blogID" + ", ");
    buffer.write("body=" + "$body");
    buffer.write("}");

    return buffer.toString();
  }

  Post copyWith(
      {String id,
      String title,
      String blogID,
      String body,
      List<TagPost> tags}) {
    return Post(
        id: id ?? this.id,
        title: title ?? this.title,
        blogID: blogID ?? this.blogID,
        body: body ?? this.body,
        tags: tags ?? this.tags);
  }

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        blogID = json['blogID'],
        body = json['body'],
        tags = json['tags'] is List
            ? (json['tags'] as List)
                .map((e) => TagPost.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'blogID': blogID,
        'body': body,
        'tags': tags?.map((e) => e?.toJson())?.toList()
      };

  static final QueryField ID = QueryField(fieldName: "post.id");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField BLOGID = QueryField(fieldName: "blogID");
  static final QueryField BODY = QueryField(fieldName: "body");
  static final QueryField TAGS = QueryField(
      fieldName: "tags",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (TagPost).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Post";
    modelSchemaDefinition.pluralName = "Posts";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.TITLE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.BLOGID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Post.BODY,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Post.TAGS,
        isRequired: false,
        ofModelName: (TagPost).toString(),
        associatedKey: TagPost.POST));
  });
}

class _PostModelType extends ModelType<Post> {
  const _PostModelType();

  @override
  Post fromJson(Map<String, dynamic> jsonData) {
    return Post.fromJson(jsonData);
  }
}
