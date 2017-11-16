Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758825AbdKPTfa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Nov 2017 14:35:30 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAGJY034010940
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2017 14:35:29 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e9etu79pa-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2017 14:35:29 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 16 Nov 2017 19:35:27 -0000
Subject: Re: [PATCH 0/4] treewide: Fix line continuation formats
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Joe Perches <joe@perches.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Thu, 16 Nov 2017 14:35:22 -0500
In-Reply-To: <1510852649.31559.38.camel@perches.com>
References: <cover.1510845910.git.joe@perches.com>
         <1510852273.3711.448.camel@linux.vnet.ibm.com>
         <1510852649.31559.38.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510860922.3711.452.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-11-16 at 09:17 -0800, Joe Perches wrote:
> On Thu, 2017-11-16 at 12:11 -0500, Mimi Zohar wrote:
> > On Thu, 2017-11-16 at 07:27 -0800, Joe Perches wrote:
> > > Avoid using line continations in formats as that causes unexpected
> > > output.
> > 
> > Is having lines greater than 80 characters the preferred method?
> 
> yes.
> 
> >  Could you add quotes before the backlash and before the first word on
> > the next line instead?
> 
> coalesced formats are preferred.

In the future, please reference the commit 6f76b6fcaa60 "CodingStyle:
Document the exception of not splitting user-visible strings, for
grepping"

thanks,

Mimi
