Return-Path: <SRS0=75dh=PQ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEA9C43387
	for <linux-integrity@archiver.kernel.org>; Tue,  8 Jan 2019 20:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D017420675
	for <linux-integrity@archiver.kernel.org>; Tue,  8 Jan 2019 20:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfAHU6s (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:58:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728854AbfAHU6s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jan 2019 15:58:48 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x08KwY7E050464
        for <linux-integrity@vger.kernel.org>; Tue, 8 Jan 2019 15:58:47 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pvyu9j8x0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 08 Jan 2019 15:58:46 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 8 Jan 2019 20:58:44 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 8 Jan 2019 20:58:43 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x08Kwggm33095768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 20:58:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C43A84C046;
        Tue,  8 Jan 2019 20:58:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F67E4C044;
        Tue,  8 Jan 2019 20:58:42 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Jan 2019 20:58:42 +0000 (GMT)
Subject: Re: OTA does not work with IMA due to xattr not supported by zip
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     rishi gupta <gupt21@gmail.com>, linux-integrity@vger.kernel.org
Date:   Tue, 08 Jan 2019 15:58:41 -0500
In-Reply-To: <CALUj-gsiY+_K_PM2kAXvVFU+wntq6tQaqUk+BVzwA3o-7nhCPw@mail.gmail.com>
References: <CALUj-gsiY+_K_PM2kAXvVFU+wntq6tQaqUk+BVzwA3o-7nhCPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010820-0016-0000-0000-0000024225EC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010820-0017-0000-0000-0000329C3BB9
Message-Id: <1546981121.19931.130.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080161
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-01-08 at 06:56 +0530, rishi gupta wrote:
> Hi Team,
> 
> Android and android recovery based implementation for Linux, generates
> ota package which is a zipped archive.
> 
> I observed that xattr gets dropped when creating zip archive and
> therefore after OTA system will not boot if IMA_APPRAISE_SIGNED_INIT
> is used.
> 
> This essentially means that IMA may not be used in commercial products
> requiring OTA or I missed something or there is a workaround to such
> problem.
> 
> https://source.android.com/devices/tech/ota/tools

Ok.  Some applications support xattrs (eg. RPM, tar); others don't
(eg. Debian packages, CPIO/initramfs).  We worked with the RPM
community to add xattr support.  Multiple attempts have been made to
add xattr support to Debian packages.

Mimi

