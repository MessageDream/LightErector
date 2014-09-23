//
//  FileHttpConnect.m
//  HttpConnect
//
//  Created by jishu on 13-4-2.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#import "FileHttpConnect.h"

@interface FileHttpConnect ()
{
    NSOutputStream *fileStream;
}
@end

@implementation FileHttpConnect
@synthesize uploadFilePath = _uploadFilePath;
@synthesize downloadFilePath = _downloadFilePath;

-(id)init
{
    if (self=[super init]) {
         __block BaseHttpConnect *blockSelf = self;
        _downloadProcess=^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead){
            if(blockSelf.observer!=nil)
                [blockSelf.observer httpConnectResponse:blockSelf getByteCount:bytesRead];
        };
        _uploadProcess=^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead){
            if(blockSelf.observer!=nil)
                [blockSelf.observer httpConnectResponse:blockSelf uploadByteCount:bytesRead];
        };

    }
    return self;
}

-(void)setDownloadFilePath:(NSString *)downloadFilePath
{
    _downloadFilePath = downloadFilePath;
    if(fileStream==nil)
    {
        fileStream = [NSOutputStream outputStreamToFileAtPath:downloadFilePath append:YES];
        
        if(fileStream==nil)
            return;
        _requestOperation.outputStream=fileStream;
    }
}
//-(BOOL)writeMemDisk:(NSData*)data
//{
//    if(fileStream==nil)
//        return NO;
//    NSInteger       dataLength;
//    const uint8_t * dataBytes;
//    NSInteger       bytesWritten;
//    NSInteger       bytesWrittenSoFar;
//    
//    // 接收到的数据长度
//    dataLength = [data length];
//    dataBytes  = [data bytes];
//    
//    bytesWrittenSoFar = 0;
//    do {
//        bytesWritten = [fileStream write:&dataBytes[bytesWrittenSoFar] maxLength:dataLength - bytesWrittenSoFar];
//        assert(bytesWritten != 0);
//        if (bytesWritten == -1) {
//            break;
//        } else {
//            bytesWrittenSoFar += bytesWritten;
//        }
//    } while (bytesWrittenSoFar != dataLength);
//    
//    return YES;
//}

////测试url：http://localhost:9000/cgi-bin/PostIt.py
//-(void) send
//{
//    if (self.uploadFilePath != nil) {
//        NSData *dataFromFile = [NSMutableData dataWithContentsOfFile:self.uploadFilePath];
//        if (dataFromFile) {
//            body = [[NSMutableData alloc]initWithData:dataFromFile];
//        }
//        unsigned long long      bodyLength;
//
////        HttpHeader,需要根据服务器参数进行定制
//        NSString *boundaryStr = [self generateBoundaryString];
//        NSString *filePath = self.uploadFilePath;
//        NSString *contentType = @"image/png";
//        
//        if(![[NSFileManager defaultManager] fileExistsAtPath:self.uploadFilePath])
//        {
//            return;
//        }
//        
//       NSNumber *fileLengthNum = (NSNumber *) [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:NULL] objectForKey:NSFileSize];
//
//        NSString *bodyPrefixStr = [NSString stringWithFormat:
//                         @
//                         // empty preamble
//                         "\r\n"
//                         "--%@\r\n"
//                         "Content-Disposition: form-data; name=\"fileContents\"; filename=\"%@\"\r\n"
//                         "Content-Type: %@\r\n"
//                         "\r\n",
//                         boundaryStr,
//                         [filePath lastPathComponent],       // +++ very broken for non-ASCII
//                         contentType
//                         ];
//        assert(bodyPrefixStr != nil);
//        
//        NSString *bodySuffixStr = [NSString stringWithFormat:
//                         @
//                         "\r\n"
//                         "--%@\r\n"
//                         "Content-Disposition: form-data; name=\"uploadButton\"\r\n"
//                         "\r\n"
//                         "Upload File\r\n"
//                         "--%@--\r\n" 
//                         "\r\n"
//                         //empty epilogue
//                         ,
//                         boundaryStr, 
//                         boundaryStr
//                         ];
//        assert(bodySuffixStr != nil);
//        
//        NSData *bodyPrefixData = [bodyPrefixStr dataUsingEncoding:NSASCIIStringEncoding];
//        NSData *bodySuffixData = [bodySuffixStr dataUsingEncoding:NSASCIIStringEncoding];
//        
//        bodyLength =
//        (unsigned long long) [bodyPrefixData length]
//        + [fileLengthNum unsignedLongLongValue]
//        + (unsigned long long) [bodySuffixData length];
//        
//        HttpHead *head1 = [[HttpHead alloc]init];
//        head1.headName = @"Content-Type";
//        head1.headValue = [NSString stringWithFormat:@"multipart/form-data; boundary=\"%@\"", boundaryStr];
//        
//        HttpHead *head2 = [[HttpHead alloc]init];
//        head2.headName = @"Content-Length";
//        head2.headValue = [NSString stringWithFormat:@"%llu", bodyLength];
//        
//        [self.resquestHeads addObject:head1];
//        [self.resquestHeads addObject:head2];
//        
//        [super send];
//    }
//}

//- (NSString *)generateBoundaryString
//{
//    CFUUIDRef       uuid;
//    CFStringRef     uuidStr;
//    NSString *      result;
//    
//    uuid = CFUUIDCreate(NULL);
//    assert(uuid != NULL);
//    
//    uuidStr = CFUUIDCreateString(NULL, uuid);
//    assert(uuidStr != NULL);
//    
//    result = [NSString stringWithFormat:@"Boundary-%@", uuidStr];
//    
//    CFRelease(uuidStr);
//    CFRelease(uuid);
//    
//    return result;
//}

//-(void)send
//{
//    NSMutableData * dataFromFile = [[NSMutableData alloc] init];
//    
//    ////////////////////////////////////按照文件格式分别放置body////////////////////////
//    //    NSMutableData *sendBody = [[NSMutableData alloc] init];
//    //    [sendBody appendData: [@"--" dataUsingEncoding:NSUTF8StringEncoding]];
//    //    [sendBody appendData: [boundary dataUsingEncoding:NSUTF8StringEncoding]];
//    //    [sendBody appendData: [@"\r\nContent-Disposition: form-data; name=" dataUsingEncoding:NSUTF8StringEncoding]];
//    //    [sendBody appendData: [@"\"" dataUsingEncoding:NSUTF8StringEncoding]];
//    //    [sendBody appendData: [((HttpPostField*)[postFieldArray objectAtIndex:n]).name dataUsingEncoding:NSUTF8StringEncoding]];
//    //    if(((HttpPostField*)[postFieldArray objectAtIndex:n]).type == HFTP_TEXT)
//    //    {
//    //        [sendBody appendData: [@"\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    //    }
//    //    else
//    //    {
//    //        [sendBody appendData: [@"\";" dataUsingEncoding:NSUTF8StringEncoding]];
//    //        [sendBody appendData: [@"filename=" dataUsingEncoding:NSUTF8StringEncoding]];
//    //        [sendBody appendData: [@"\"" dataUsingEncoding:NSUTF8StringEncoding]];
//    //        [sendBody appendData: [@"entity_0" dataUsingEncoding:NSUTF8StringEncoding]];
//    //        [sendBody appendData: [@"\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    //    }
//    //    [sendBody appendData: [@"--" dataUsingEncoding:NSUTF8StringEncoding]];
//    //    [sendBody appendData: [boundary dataUsingEncoding:NSUTF8StringEncoding]];
//    //    [sendBody appendData: [@"--\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    ///////////////////////////////////按照文件格式和公用http字段上传文件/////////////////
//    if (self.requestFilePath != nil) {
//        dataFromFile = [NSMutableData dataWithContentsOfFile:self.requestFilePath];
//        if (dataFromFile) {
//            body = dataFromFile;
//        }
//    
//    [super send];
//}
//- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data
//{
//    assert(theConnection == connection);
//    
//    if(self.downloadFilePath!=nil)
//    {
//        if(![self writeMemDisk:data])
//        {
//            _errorCode = HttpErrorCode_WriteFileFail;
//            if (self.observer) 
//                [self.observer didHttpConnectError:_errorCode];
//            [self closeConnect];
//        }
//    }
//    else
//        [dataBuffer appendData:data];
//        
//    if(self.observer!=nil)
//        [self.observer httpConnectResponse:self GetByteCount:data.length];
//    
//}
//-(void)didGetHttpConnectResponseHead:(NSDictionary*)allHead
//{
//    NSLog(@"receive header:%@",allHead);
//}
-(void)closeConnect
{
    if(fileStream!=nil)
        [fileStream close];
    [super closeConnect];
}
@end
