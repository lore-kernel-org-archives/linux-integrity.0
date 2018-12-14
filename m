Return-Path: <SRS0=e5UK=OX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABF7C43387
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Dec 2018 19:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBB3206C0
	for <linux-integrity@archiver.kernel.org>; Fri, 14 Dec 2018 19:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbeLNTBz (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:01:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730123AbeLNTBy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Dec 2018 14:01:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBEJ1HAI025357
        for <linux-integrity@vger.kernel.org>; Fri, 14 Dec 2018 14:01:53 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pcja8r12k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 14 Dec 2018 14:01:52 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 14 Dec 2018 19:01:51 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Dec 2018 19:01:48 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBEJ1lMe60817586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 19:01:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBA9EA404D;
        Fri, 14 Dec 2018 19:01:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 108BAA4040;
        Fri, 14 Dec 2018 19:01:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.89.160])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Dec 2018 19:01:46 +0000 (GMT)
Subject: Re: Bug: Persisting O_TMPFILE with IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ignaz Forster <iforster@suse.de>, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, Fabian Vogt <fvogt@suse.de>
Date:   Fri, 14 Dec 2018 14:01:36 -0500
In-Reply-To: <884653bf-2e25-b78f-2dc7-51c5a57d4b51@suse.de>
References: <884653bf-2e25-b78f-2dc7-51c5a57d4b51@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121419-0016-0000-0000-00000236981E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121419-0017-0000-0000-0000328ED93B
Message-Id: <1544814096.3681.12.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=924 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140161
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2018-12-14 at 19:11 +0100, Ignaz Forster wrote:
> Hello,
> 
> persisting files opened with O_TMPFILE doesn't seem to work on IMA as 
> expected: The IMA xattr won't be written. This makes it impossible to 
> access the file later.
> The following example application, based on the O_TMPFILE example from
> 	man 2 open
> will demonstrate this:
> 
> 
> #include <fcntl.h>
> #include <unistd.h>
> #include <linux/limits.h>
> #include <stdio.h>
> 
> int main(int argc, char *argv[]) {
> 	char path[PATH_MAX];
> 	int fd = open("/tmp", __O_TMPFILE | O_RDWR, S_IRUSR | S_IWUSR);
> 	write(fd, "test", 4);
> 	snprintf(path, PATH_MAX, "/proc/self/fd/%d", fd);
> 	linkat(AT_FDCWD, path, AT_FDCWD, "/tmp/tmpfile_persisted.txt",
> 			AT_SYMLINK_FOLLOW);
> }
> 
> 
> (/tmp should not be a tmpfs of course; change to paths to a supported 
> file system if necessary.)
> 
> This was discovered when trying to understand why IMA is failing on 
> overlayfs during truncated copy_up operations (see thread "PROBLEM: IMA 
> xattrs not written on overlayfs" from September / October), though this 
> is probably a different problem.

rootfs is a tmpfs filesystem.  Once CPIO supports xattrs, they can be
included in the initramfs.

Remember the builtin policies - ima_policy=tcb|appraise_tcb - are
there from boot.  They are meant to be replaced with finer grained
policies based on LSM labels, once the LSMs are up and running.

Feel free to replace the builtin IMA policy with one to your liking.

Mimi

