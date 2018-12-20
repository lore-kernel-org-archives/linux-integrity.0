Return-Path: <SRS0=gF99=O5=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4324C43387
	for <linux-integrity@archiver.kernel.org>; Thu, 20 Dec 2018 14:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7985E2186A
	for <linux-integrity@archiver.kernel.org>; Thu, 20 Dec 2018 14:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbeLTOzf (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:55:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbeLTOzf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Dec 2018 09:55:35 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBKErgC3118504
        for <linux-integrity@vger.kernel.org>; Thu, 20 Dec 2018 09:55:33 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pgb5cemqd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 20 Dec 2018 09:55:33 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 20 Dec 2018 14:55:31 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Dec 2018 14:55:29 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBKEtSpd28442686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Dec 2018 14:55:28 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6022111C050;
        Thu, 20 Dec 2018 14:55:28 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7388F11C04C;
        Thu, 20 Dec 2018 14:55:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.105.65])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Dec 2018 14:55:27 +0000 (GMT)
Subject: Re: EVM: Permission denied with overlayfs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     iforster@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Date:   Thu, 20 Dec 2018 09:55:16 -0500
In-Reply-To: <1545257296.2916.42.camel@HansenPartnership.com>
References: <12c81a49-efca-d66c-2143-ae04ca248cce@suse.de>
         <1545174031.4178.8.camel@linux.ibm.com>
         <1545233975.3954.8.camel@linux.ibm.com>
         <1545238601.2916.13.camel@HansenPartnership.com>
         <1545243311.3954.22.camel@linux.ibm.com>
         <1545248096.2916.26.camel@HansenPartnership.com>
         <CAOQ4uxhDh3okp1nYgZXxG+2siChfT8Oq3ncH1FFhQW_zBCstzw@mail.gmail.com>
         <1545253341.3954.83.camel@linux.ibm.com>
         <1545257296.2916.42.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18122014-0028-0000-0000-0000032D432F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122014-0029-0000-0000-000023E9A9D3
Message-Id: <1545317716.4077.33.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812200123
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2018-12-19 at 14:08 -0800, James Bottomley wrote:

> > For portable signatures, to bind the file metadata with the file 
> > data, we've replaced the inode number and generation, with the
> > "security.ima" xattr.  Do we want this requirement/limitation for
> > overlays?
> 
> Well, that's my question, yes.  I think there's a reasonable case for
> it, but I was wondering what value the inode number and generation
> brings.  Is there some reason to bind the EVM signature to a more
> mutable file container (which is what inum/generation provide) rather
> than a hard hash of file content (which is what the ima xattr
> provides)?

As only files in the IMA policy are labeled with security.ima, to
protect other files and directories, requires including the inode
number, generation and the UUID.

> > The existing EVM portable signature is an asymmetric algorithm based
> > signature.  Would we define a "portable" HMAC?
> 
> Well, a signature is just an encryption of a hash.  Whether you do HMAC
> with symmetric key or RSA/EC with an asymmetric one is more an
> operational question.  HMAC is certainly much faster but EVM only has a
> single hmac key which is problematic for the containers.  Without a use
> case I can't really say.  Instinct tells me asymmetric is more suitable
> to the container use case, but that's really just a guess.

One of the differences between the EVM portable signature type and the
original signature type is that the portable signatures aren't
replaced with an HMAC.  They're considered portable & immutable.

Adding kernel support for signing mutable files using an asymmetric
key is going to blur the lines between mutable/immutable files.

Mimi

