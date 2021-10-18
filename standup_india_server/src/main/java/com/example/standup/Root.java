package com.example.standup;


import java.util.ArrayList;
import java.util.List;

 class ContentDetails {
    private String duration;
    private String dimension;
    private String definition;
    private String caption;
    private Boolean licensedContent;
    private ContentRating contentRating;
    private String projection;
    public String getDuration() {
        return duration;
    }
    public void setDuration(String duration) {
        this.duration = duration;
    }
    public String getDimension() {
        return dimension;
    }
    public void setDimension(String dimension) {
        this.dimension = dimension;
    }
    public String getDefinition() {
        return definition;
    }
    public void setDefinition(String definition) {
        this.definition = definition;
    }
    public String getCaption() {
        return caption;
    }
    public void setCaption(String caption) {
        this.caption = caption;
    }
    public Boolean getLicensedContent() {
        return licensedContent;
    }
    public void setLicensedContent(Boolean licensedContent) {
        this.licensedContent = licensedContent;
    }
    public ContentRating getContentRating() {
        return contentRating;
    }
    public void setContentRating(ContentRating contentRating) {
        this.contentRating = contentRating;
    }
    public String getProjection() {
        return projection;
    }
    public void setProjection(String projection) {
        this.projection = projection;
    }
}
 class ContentRating {
}
 class Default {
    private String url;
    private Integer width;
    private Integer height;
    public String getUrl() {
        return url;
    }
    public void setUrl(String url) {
        this.url = url;
    }
    public Integer getWidth() {
        return width;
    }
    public void setWidth(Integer width) {
        this.width = width;
    }
    public Integer getHeight() {
        return height;
    }
    public void setHeight(Integer height) {
        this.height = height;
    }
}
 class High {
    private String url;
    private Integer width;
    private Integer height;
    public String getUrl() {
        return url;
    }
    public void setUrl(String url) {
        this.url = url;
    }
    public Integer getWidth() {
        return width;
    }
    public void setWidth(Integer width) {
        this.width = width;
    }
    public Integer getHeight() {
        return height;
    }
    public void setHeight(Integer height) {
        this.height = height;
    }
}
 class Item {
    private String kind;
    private String etag;
    private String id;
    private Snippet snippet;
    private ContentDetails contentDetails;
    private Status status;
    private Statistics statistics;
    public String getKind() {
        return kind;
    }
    public void setKind(String kind) {
        this.kind = kind;
    }
    public String getEtag() {
        return etag;
    }
    public void setEtag(String etag) {
        this.etag = etag;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public Snippet getSnippet() {
        return snippet;
    }
    public void setSnippet(Snippet snippet) {
        this.snippet = snippet;
    }
    public ContentDetails getContentDetails() {
        return contentDetails;
    }
    public void setContentDetails(ContentDetails contentDetails) {
        this.contentDetails = contentDetails;
    }
    public Status getStatus() {
        return status;
    }
    public void setStatus(Status status) {
        this.status = status;
    }
    public Statistics getStatistics() {
        return statistics;
    }
    public void setStatistics(Statistics statistics) {
        this.statistics = statistics;
    }
}

 class Localized {
    private String title;
    private String description;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
}

 class Medium {
    private String url;
    private Integer width;
    private Integer height;
    public String getUrl() {
        return url;
    }
    public void setUrl(String url) {
        this.url = url;
    }
    public Integer getWidth() {
        return width;
    }
    public void setWidth(Integer width) {
        this.width = width;
    }
    public Integer getHeight() {
        return height;
    }
    public void setHeight(Integer height) {
        this.height = height;
    }
}
class PageInfo {
    private Integer totalResults;
    private Integer resultsPerPage;
    public Integer getTotalResults() {
        return totalResults;
    }
    public void setTotalResults(Integer totalResults) {
        this.totalResults = totalResults;
    }
    public Integer getResultsPerPage() {
        return resultsPerPage;
    }
    public void setResultsPerPage(Integer resultsPerPage) {
        this.resultsPerPage = resultsPerPage;
    }
}
public class Root {
    private String kind;
    private String etag;
    private List<Item> items = new ArrayList<Item>();
    private PageInfo pageInfo;
    public String getKind() {
        return kind;
    }
    public void setKind(String kind) {
        this.kind = kind;
    }
    public String getEtag() {
        return etag;
    }
    public void setEtag(String etag) {
        this.etag = etag;
    }
    public List<Item> getItems() {
        return items;
    }
    public void setItems(List<Item> items) {
        this.items = items;
    }
    public PageInfo getPageInfo() {
        return pageInfo;
    }
    public void setPageInfo(PageInfo pageInfo) {
        this.pageInfo = pageInfo;
    }
}
 class Snippet {
    private String publishedAt;
    private String channelId;
    private String title;
    private String description;
    private String channelTitle;
    private List<String> tags = new ArrayList<String>();
    private String categoryId;
    private String liveBroadcastContent;
    private Localized localized;
    public String getPublishedAt() {
        return publishedAt;
    }
    public void setPublishedAt(String publishedAt) {
        this.publishedAt = publishedAt;
    }
    public String getChannelId() {
        return channelId;
    }
    public void setChannelId(String channelId) {
        this.channelId = channelId;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public String getChannelTitle() {
        return channelTitle;
    }
    public void setChannelTitle(String channelTitle) {
        this.channelTitle = channelTitle;
    }
    public List<String> getTags() {
        return tags;
    }
    public void setTags(List<String> tags) {
        this.tags = tags;
    }
    public String getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }
    public String getLiveBroadcastContent() {
        return liveBroadcastContent;
    }
    public void setLiveBroadcastContent(String liveBroadcastContent) {
        this.liveBroadcastContent = liveBroadcastContent;
    }
    public Localized getLocalized() {
        return localized;
    }
    public void setLocalized(Localized localized) {
        this.localized = localized;
    }
}
 class Statistics {
    private String viewCount;
    private String likeCount;
    private String dislikeCount;
    private String favoriteCount;
    private String commentCount;
    public String getViewCount() {
        return viewCount;
    }
    public void setViewCount(String viewCount) {
        this.viewCount = viewCount;
    }
    public String getLikeCount() {
        return likeCount;
    }
    public void setLikeCount(String likeCount) {
        this.likeCount = likeCount;
    }
    public String getDislikeCount() {
        return dislikeCount;
    }
    public void setDislikeCount(String dislikeCount) {
        this.dislikeCount = dislikeCount;
    }
    public String getFavoriteCount() {
        return favoriteCount;
    }
    public void setFavoriteCount(String favoriteCount) {
        this.favoriteCount = favoriteCount;
    }
    public String getCommentCount() {
        return commentCount;
    }
    public void setCommentCount(String commentCount) {
        this.commentCount = commentCount;
    }
}
 class Status {
     private String uploadStatus;
     private String privacyStatus;
     private String license;
     private Boolean embeddable;
     private Boolean publicStatsViewable;
     private Boolean madeForKids;

     public String getUploadStatus() {
         return uploadStatus;
     }

     public void setUploadStatus(String uploadStatus) {
         this.uploadStatus = uploadStatus;
     }

     public String getPrivacyStatus() {
         return privacyStatus;
     }

     public void setPrivacyStatus(String privacyStatus) {
         this.privacyStatus = privacyStatus;
     }

     public String getLicense() {
         return license;
     }

     public void setLicense(String license) {
         this.license = license;
     }

     public Boolean getEmbeddable() {
         return embeddable;
     }

     public void setEmbeddable(Boolean embeddable) {
         this.embeddable = embeddable;
     }

     public Boolean getPublicStatsViewable() {
         return publicStatsViewable;
     }

     public void setPublicStatsViewable(Boolean publicStatsViewable) {
         this.publicStatsViewable = publicStatsViewable;
     }

     public Boolean getMadeForKids() {
         return madeForKids;
     }

     public void setMadeForKids(Boolean madeForKids) {
         this.madeForKids = madeForKids;
     }

     class Thumbnails {
         private Default _default;
         private Medium medium;
         private High high;

         public Default getDefault() {
             return _default;
         }

         public void setDefault(Default _default) {
             this._default = _default;
         }

         public Medium getMedium() {
             return medium;
         }

         public void setMedium(Medium medium) {
             this.medium = medium;
         }

         public High getHigh() {
             return high;
         }

         public void setHigh(High high) {
             this.high = high;
         }
     }
 }

