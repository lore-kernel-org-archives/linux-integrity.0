Return-Path: <SRS0=1iot=RN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7FFC43381
	for <linux-integrity@archiver.kernel.org>; Sun, 10 Mar 2019 23:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D1C20657
	for <linux-integrity@archiver.kernel.org>; Sun, 10 Mar 2019 23:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfCJX15 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 10 Mar 2019 19:27:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726980AbfCJX15 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Mar 2019 19:27:57 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2ANPOhe060124
        for <linux-integrity@vger.kernel.org>; Sun, 10 Mar 2019 19:27:55 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r58ecehp6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 10 Mar 2019 19:27:55 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 10 Mar 2019 23:27:53 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 10 Mar 2019 23:27:51 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2ANRp6m34865300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 10 Mar 2019 23:27:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E49CA11C04C;
        Sun, 10 Mar 2019 23:27:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EDF211C04A;
        Sun, 10 Mar 2019 23:27:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.170])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 Mar 2019 23:27:50 +0000 (GMT)
Subject: Re: [PATCH v2] ima-evm-utils: simplify digest alias handling
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Sun, 10 Mar 2019 19:27:39 -0400
In-Reply-To: <20190310230824.wjx6x3c5ddqjj4su@altlinux.org>
References: <20190212224631.13398-1-vt@altlinux.org>
         <1552256785.6100.4.camel@linux.ibm.com>
         <20190310230824.wjx6x3c5ddqjj4su@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031023-0012-0000-0000-000003010B47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031023-0013-0000-0000-0000213823F3
Message-Id: <1552260459.6100.21.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-10_20:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=838 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903100181
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-03-11 at 02:08 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Sun, Mar 10, 2019 at 06:26:25PM -0400, Mimi Zohar wrote:
> > Hi Vitaly,
> > 
> > On Wed, 2019-02-13 at 01:46 +0300, Vitaly Chikunov wrote:
> > > - Make digest name search work just with simple strcmp() and three
> > >   arrays, dropping strmatch().
> > > - Remove get_digestbyname() which was doing two hash name resolving
> > >   attempts, reverting to use plain EVP_get_digestbyname(). This will
> > >   force the user to specify the proper hash name depending on what
> > >   OpenSSL provides, allowing to specify older hash name in older
> > >   OpenSSL.
> > > - Improve hash_info parser to produce hash_algo_name[] more resembling
> > >   what is in the kernel, making algocmp() not needed and removed.
> > > - Fix indent in get_hash_algo_by_id().
> > 
> > Thanks, this is a lot better.  As there isn't a "Signed-off-by", did
> 
> Forgot this. I can resend with "Signed-off-by".
> 
> > you want to squash this with the original patch - "Extract digest
> > algorithms from hash_info.h"?
> 
> Do you mean rebase squash with already upstreamed commit? Did not know
> this is allowed.

Agreed, normally it shouldn't be done, but it hasn't been included in
a release.  Defining and then removing algocmp() doesn't make sense.

> 
> If you want to do it, this probably should not be squashed with "Extract
> digest algorithms from hash_info.h", but with "Try to load digest by its
> alias", because it is simplification of this commit.

Unless there is a reason for keeping these patches separate, please
squash them.  It will be easier for anyone reviewing the code.

Thanks!

Mimi

