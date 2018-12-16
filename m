Return-Path: <SRS0=mxGM=OZ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F8CC43387
	for <linux-integrity@archiver.kernel.org>; Sun, 16 Dec 2018 14:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B29D2086C
	for <linux-integrity@archiver.kernel.org>; Sun, 16 Dec 2018 14:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbeLPOgi (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 16 Dec 2018 09:36:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729822AbeLPOgh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Dec 2018 09:36:37 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBGEYUgI147062
        for <linux-integrity@vger.kernel.org>; Sun, 16 Dec 2018 09:36:36 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pdfuspahn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 16 Dec 2018 09:36:36 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 16 Dec 2018 14:36:34 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 16 Dec 2018 14:36:32 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBGEaVEs35651730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 16 Dec 2018 14:36:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B43DD4C040;
        Sun, 16 Dec 2018 14:36:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97B4A4C046;
        Sun, 16 Dec 2018 14:36:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.105.202])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 16 Dec 2018 14:36:30 +0000 (GMT)
Subject: Re: Bug: Persisting O_TMPFILE with IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ignaz Forster <ignaz.forster@gmx.de>, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, Fabian Vogt <fvogt@suse.de>
Date:   Sun, 16 Dec 2018 09:36:19 -0500
In-Reply-To: <8dd90198-00ef-a43f-194b-9c4dcfc2227a@gmx.de>
References: <884653bf-2e25-b78f-2dc7-51c5a57d4b51@suse.de>
         <1544814096.3681.12.camel@linux.ibm.com>
         <8dd90198-00ef-a43f-194b-9c4dcfc2227a@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121614-0016-0000-0000-000002374798
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121614-0017-0000-0000-0000328F8D3B
Message-Id: <1544970979.4541.10.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-16_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=861 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812160138
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2018-12-15 at 12:07 +0100, Ignaz Forster wrote:
> Mimi Zohar schrieb am 14.12.2018 um 20:01 Uhr:
> > On Fri, 2018-12-14 at 19:11 +0100, Ignaz Forster wrote:
> >> Hello,
> >>
> >> persisting files opened with O_TMPFILE doesn't seem to work on IMA as 
> >> expected: The IMA xattr won't be written. This makes it impossible to 
> >> access the file later.
> >> The following example application, based on the O_TMPFILE example from
> >> 	man 2 open
> >> will demonstrate this:
> >>
> >>
> >> #include <fcntl.h>
> >> #include <unistd.h>
> >> #include <linux/limits.h>
> >> #include <stdio.h>
> >>
> >> int main(int argc, char *argv[]) {
> >> 	char path[PATH_MAX];
> >> 	int fd = open("/tmp", __O_TMPFILE | O_RDWR, S_IRUSR | S_IWUSR);
> >> 	write(fd, "test", 4);
> >> 	snprintf(path, PATH_MAX, "/proc/self/fd/%d", fd);
> >> 	linkat(AT_FDCWD, path, AT_FDCWD, "/tmp/tmpfile_persisted.txt",
> >> 			AT_SYMLINK_FOLLOW);
> >> }
> >>
> >>
> >> (/tmp should not be a tmpfs of course; change to paths to a supported 
> >> file system if necessary.)

[ snip ]

There is indeed a missing call to ima_file_check() in do_tmpfile(),
but it requires FMODE_CREATED to be set.  Al, is there a reason that
FMODE_CREATED is not set?

Mimi

