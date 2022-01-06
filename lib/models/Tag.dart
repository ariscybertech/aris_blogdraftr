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

/** This is an auto generated class representing the Tag type in your schema. */
@immutable
class Tag extends Model {
  static const classType = const _TagModelType();
  final String id;
  final String name;
  final List<TagPost> posts;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Tag._internal({@required this.id, @required this.name, this.posts});

  factory Tag({String id, @required String name, List<TagPost> posts}) {
    return Tag._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        posts: posts != null ? List.unmodifiable(posts) : posts);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Tag &&
        id == other.id &&
        name == other.name &&
        DeepCollectionEquality().equals(posts, other.posts);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Tag {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name");
    buffer.write("}");

    return buffer.toString();
  }

  Tag copyWith({String id, String name, List<TagPost> posts}) {
    return Tag(
        id: id ?? this.id, name: name ?? this.name, posts: posts ?? this.posts);
  }

  Tag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        posts = json['posts'] is List
            ? (json['posts'] as List)
                .map((e) => TagPost.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posts': posts?.map((e) => e?.toJson())?.toList()
      };

  static final QueryField ID = QueryField(fieldName: "tag.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField POSTS = QueryField(
      fieldName: "posts",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (TagPost).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Tag";
    modelSchemaDefinition.pluralName = "Tags";

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
        key: Tag.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Tag.POSTS,
        isRequired: false,
        ofModelName: (TagPost).toString(),
        associatedKey: TagPost.TAG));
  });
}

class _TagModelType extends ModelType<Tag> {
  const _TagModelType();

  @override
  Tag fromJson(Map<String, dynamic> jsonData) {
    return Tag.fromJson(jsonData);
  }
}
