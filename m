Return-Path: <SRS0=MdHQ=RR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92569C43381
	for <linux-integrity@archiver.kernel.org>; Thu, 14 Mar 2019 23:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5053D20811
	for <linux-integrity@archiver.kernel.org>; Thu, 14 Mar 2019 23:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfCNX7I (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 14 Mar 2019 19:59:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727603AbfCNX7I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Mar 2019 19:59:08 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2ENsBmt013714
        for <linux-integrity@vger.kernel.org>; Thu, 14 Mar 2019 19:59:07 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r7ybemgye-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 14 Mar 2019 19:59:07 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 14 Mar 2019 23:59:05 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 23:59:01 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2ENx0K261341762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 23:59:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA0A15204E;
        Thu, 14 Mar 2019 23:59:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.108.186])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3213B52052;
        Thu, 14 Mar 2019 23:59:00 +0000 (GMT)
Subject: Re: [RFC] kexec: Allow kexec_file() with appropriate IMA policy
 when locked down
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Thu, 14 Mar 2019 19:58:49 -0400
In-Reply-To: <CACdnJuuySXLON5=m9VCqAsv+-wQnZQKRi0=SRpbTiRbhuCOq4g@mail.gmail.com>
References: <20190312195715.101995-1-matthewgarrett@google.com>
         <1552478316.24794.210.camel@linux.ibm.com>
         <CACdnJuvThFMhGtKT9PYSH-jZD69CBktQNiJmCc=d4PFRbzQvGw@mail.gmail.com>
         <1552512556.24794.229.camel@linux.ibm.com>
         <CACdnJutmJDLhrdsU9UZtzE+S=Tw39RYqZ3q+TP35PbFbfsL76w@mail.gmail.com>
         <1552525698.24794.237.camel@linux.ibm.com>
         <CACdnJuv=-Gr9Psd1ABZ=fW43-2FHcgEkG_iu0bY20Jx4Vro=mA@mail.gmail.com>
         <1552602691.8658.49.camel@linux.ibm.com>
         <CACdnJuuySXLON5=m9VCqAsv+-wQnZQKRi0=SRpbTiRbhuCOq4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031423-0016-0000-0000-000002630586
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031423-0017-0000-0000-000032BE05B5
Message-Id: <1552607929.8658.54.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140162
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-03-14 at 15:54 -0700, Matthew Garrett wrote:
> On Thu, Mar 14, 2019 at 3:31 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Thu, 2019-03-14 at 14:08 -0700, Matthew Garrett wrote:
> > > On Wed, Mar 13, 2019 at 6:08 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > The IMA hash and EVM hmac combination is fine for offline protection.
> > > > It's used for mutable files.  For immutable files, there must be
> > > > either an IMA or EVM signature.
> > >
> > > Ok. Is the correct way to handle this to check that the file has a
> > > signature, or to extend IMA policy to allow it to provide a
> > > requirement that EVM verify a signature rather than an HMAC and have
> > > the arch policy set that?
> >
> > I'm not sure what you mean by "check that the file has a signature".
> 
> Call getxattr(XATTR_SECURITY_EVM) and parse the type to determine
> whether it's an hmac or a signature.

The other option is preferable.

> 
> > EVM and IMA are separate subsystems with a defined interface for
> > interaction between them. evm_verifyxattr() isn't, but could be called
> > by LSMs.  So evm_verifyxattr() would need to be extended to return the
> > EVM xattr type.  The IMA policy could then require a specific evmxattr
> > type.  Possible.
> 
> I'd been thinking of doing it the other way (ie, pass the set of
> permitted EVM xattr types to evm_verifyxattr()), but yes.

Just as IMA decides how it wants to handle "no xattrs", let IMA decide
how it wants to handle the different EVM xattr types.

> 
> > Perhaps for now require IMA signatures and defer supporting EVM
> > signatures?
> 
> If that's sufficient for you, happy to do that.

Definitely

Mimi

