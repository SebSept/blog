import {slugifyStr} from "./slugify";
import type {CollectionEntry} from "astro:content";
import postFilter from "./postFilter";

interface Tag {
  tag: string;
  tagName: string;
  count: number;
}

const getUniqueTags = (posts: CollectionEntry<"blog">[]) => {
  const tags: Tag[] = posts
    .filter(postFilter)
    .flatMap(post => post.data.tags)
    .map(tag => ({ tag: slugifyStr(tag), tagName: tag, count: 0 }))
    // ajout du compte du nombre d'occurences
    .map((tag, index, self) => {
      const count = self.filter(t => tag.tag === t.tag).length;
      return { ...tag, count: count };
    })
    // filtrage par nombre d'occurences
    .filter(tag => tag.count > 1)
    .filter(
      (value, index, self) =>
        self.findIndex(tag => tag.tag === value.tag) === index
    )
    .sort((tagA, tagB) => tagA.tag.localeCompare(tagB.tag));
  return tags;
};

export default getUniqueTags;
