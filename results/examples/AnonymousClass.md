# Example 1
Frame 8 of `ES-21457` (shown below) points to a lambda expression.
```
org.elasticsearch.action.search.SearchTransportService.lambda$registerRequestHandler$684(SearchTransportService.java:311)
```
The source code of this lambda expression is:
```java
transportService.registerRequestHandler(FETCH_ID_ACTION_NAME, ShardFetchSearchRequest::new, ThreadPool.Names.SEARCH,
    (request, channel) -> {
        FetchSearchResult result = searchService.executeFetchPhase(request);
        channel.sendResponse(result);
    });
```
# Example 2
In `XWIKI-12855`, frames 30 and 31 points to the following anonymous class:

```java
return getStore().executeRead(getContext(), new HibernateCallback<List<T>>()
{
    @SuppressWarnings("unchecked")
    @Override
    public List<T> doInHibernate(Session session)
    {
        org.hibernate.Query hquery = createHibernateQuery(session, query);
        populateParameters(hquery, query);

        List<T> results = hquery.list();
        if (query.getFilters() != null && !query.getFilters().isEmpty()) {
            for (QueryFilter filter : query.getFilters()) {
                results = filter.filterResults(results);
            }
        }
        return results;
    }
});
```
