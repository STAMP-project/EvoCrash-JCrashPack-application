# Example 1
The are some cases that the target method has more than 100 lines of code. For instance, frame 3 of `XWIKI-13096` points to a method which has 360 lines of code. This method is `execute()` in class `XWikiAction`, and it starts from line 195 until line 556.

# Example 2
In some of the cases, the number of lines of the code is nit that much high. Although, there are lots of loops and conditions in the target method. For instance frame 10 of crash `ES-22373` points to method `execute()` This method is indicated in the following code:
```java
public BatchResult<PutMappingClusterStateUpdateRequest> execute(ClusterState currentState,
                                                                List<PutMappingClusterStateUpdateRequest> tasks) throws Exception {
    Set<Index> indicesToClose = new HashSet<>();
    BatchResult.Builder<PutMappingClusterStateUpdateRequest> builder = BatchResult.builder();
    try {
        // precreate incoming indices;
        for (PutMappingClusterStateUpdateRequest request : tasks) {
            try {
                for (Index index : request.indices()) {
                    final IndexMetaData indexMetaData = currentState.metaData().getIndexSafe(index);
                    if (indicesService.hasIndex(indexMetaData.getIndex()) == false) {
                        // if the index does not exists we create it once, add all types to the mapper service and
                        // close it later once we are done with mapping update
                        indicesToClose.add(indexMetaData.getIndex());
                        IndexService indexService = indicesService.createIndex(nodeServicesProvider, indexMetaData,
                            Collections.emptyList());
                        // add mappings for all types, we need them for cross-type validation
                        for (ObjectCursor<MappingMetaData> mapping : indexMetaData.getMappings().values()) {
                            indexService.mapperService().merge(mapping.value.type(), mapping.value.source(),
                                MapperService.MergeReason.MAPPING_RECOVERY, request.updateAllTypes());
                        }
                    }
                }
                currentState = applyRequest(currentState, request);
                builder.success(request);
            } catch (Exception e) {
                builder.failure(request, e);
            }
        }
        return builder.build(currentState);
    } finally {
        for (Index index : indicesToClose) {
            indicesService.removeIndex(index, "created for mapping processing");
        }
    }
}
```
