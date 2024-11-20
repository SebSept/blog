import {slugifyStr} from "./slugify";
import type {CollectionEntry} from "astro:content";
import postFilter from "./postFilter";
import { SITE } from "@config";

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
    // ajout du compte du nombre d'occurrences
    .map((tag, _, self) => {
        return { ...tag, count: self.filter(t => tag.tag === t.tag).length };
    })
    // filtrage par nombre d'occurrences
    .filter(tag => tag.count >= SITE.minTagOccurrences)
    .filter(
      (value, index, self) =>
        self.findIndex(tag => tag.tag === value.tag) === index
    )
    .sort((tagA, tagB) => tagA.tag.localeCompare(tagB.tag));
  return tags;
};

export default getUniqueTags;
