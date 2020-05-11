API:

## Get a process ID:
====================
```
mutation{
  generateProcessId
}
```

## Upload and parse a CSV file:
===============================

```
curl -X POST \
-F query='mutation { uploadFile(data: "csv_file", processId: PROCESS_ID_HERE)}' \
-F csv_file=@sample.csv \
localhost:4000/api
```

## Get failure reasons:
=======================
```
query{
  getFailureReasons(processId: PROCESS_ID_HERE) {
    nameAr
    nameEn
    descriptionAr
    descriptionEn
    price
    listed
  }
}
```

## Subscribe to report (live updates):
======================================
```
subscription {
  liveReport(processId: PROCESS_ID_HERE) {
    failure
    remainingRows
    success
  }
}
```
