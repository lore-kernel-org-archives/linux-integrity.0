Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752822AbeCOVYR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Mar 2018 17:24:17 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2FLLdG3026275
        for <linux-integrity@vger.kernel.org>; Thu, 15 Mar 2018 17:24:17 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gqxw44tq5-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 15 Mar 2018 17:24:16 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 15 Mar 2018 21:24:14 -0000
Subject: Re: [PATCH v3 4/4] fuse: define the filesystem as untrusted
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Michael Halcrow <mhalcrow@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Stef Bon <stefbon@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>, "Ted Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@google.com>
Date: Thu, 15 Mar 2018 17:24:07 -0400
In-Reply-To: <20180314225338.GA147255@google.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
         <CANXojczCU3UC4xsPYzAYqFW3_WR9Z7QO_exd4dB6eyQR2STuUg@mail.gmail.com>
         <1521032461.3547.404.camel@linux.vnet.ibm.com>
         <877eqer5r6.fsf@xmission.com>
         <1521049841.3547.500.camel@linux.vnet.ibm.com>
         <279C5F8D-9A75-44C7-8287-023F634BB3A0@oracle.com>
         <87in9yo2xq.fsf@xmission.com>
         <874F0391-1E88-498E-970B-78674057028D@oracle.com>
         <87a7vamizo.fsf@xmission.com> <20180314225338.GA147255@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521149047.3547.674.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-03-14 at 15:53 -0700, Michael Halcrow wrote:
> On Wed, Mar 14, 2018 at 04:42:51PM -0500, Eric W. Biederman wrote:
> > In this case I mean trust as in the believe that the server is not
> > actively trying to subvert the guarantees that IMA is depending
> > upon.
> 
> The fs-verity adversarial model we're targeting includes a malicious
> layer backing the local file system inode's page cache.
> 
> For example, the malicious layer can be a drive controller with
> trojaned firmware or a compromised remote server.
> 
> > What happens if the server on the first read returns an innocuous
> > file that matches it's ima xattr, but on the next read of the file
> > returns an evil trojan horse.  Or what if the server implements a
> > cache coherency protocol but lies and does not report all of the
> > changes to a file.
> 
> fs-verity validates each page in the inode's page cache against the
> inode's root-of-trust every time the page is read into the cache.
> 
> The signature mechanism on the root-of-trust must bind the inode
> identity.
> 
> The initial version of fs-verity supports Secure Boot, and the TCB
> validates each inode identity in the mount during the boot process.
> fs-verity does this via an ioctl that provisions the fs-verity
> measurement, causing the inode (along with its immutable measurement)
> to be pinned by the superblock for the life of the mount.  This meets
> requirements for the Android platform's use case, which only needs to
> cover about 15 APKs during boot.
> 
> This doesn't scale.  Future work will include integration with PKCS7
> and/or IMA.  Signatures will be dynamically verifiable against a key
> or keys in the TCB, and I'd like to establish a safe way to avoid
> having to pin inodes and their measurements.

Next steps should also include identifying methods for storing and
transporting the Merkle tree signature without having to read the
entire file for remote filesystems.

With this fs support, signed files on file systems mounted with the
 SB_I_IMA_UNVERIFIABLE_SIGNATURE flag would then be verifiable.  

Mimi
